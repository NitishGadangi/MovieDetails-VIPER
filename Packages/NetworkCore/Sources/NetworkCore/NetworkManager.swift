//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}

enum ResponseResult<String> {
    case success
    case failure(String)
}

public enum NetworkManagerEnv {
    case prod
    case stage
}

public class NetworkManager<EndPoint: EndPointType> {
    private let networkServiceProd = NetworkService<EndPoint>()
    private let networkServiceStage = NetworkServiceMock<EndPoint>()
    var env: NetworkManagerEnv = .prod
    private var networkService: any NetworkServiceble<EndPoint> {
        get {
            switch env {
                case .prod:
                    return networkServiceProd
                case .stage:
                    return networkServiceStage
            }
        }
    }

    func sendRequest<T: Decodable>(endPoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        networkService.request(endPoint) { data, response, error in
            if let error {
                let networkError = NetworkError(message: NetworkResponse.failed.rawValue)
                completion(.failure(networkError))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                    case .success:
                        guard let responseData = data else {
                            let networkError = NetworkError(message: NetworkResponse.noData.rawValue)
                            completion(.failure(networkError))
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                            completion(.success(apiResponse))
                        } catch {
                            print(error)
                            let networkError = NetworkError(message: NetworkResponse.unableToDecode.rawValue)
                            completion(.failure(networkError))
                        }
                    case .failure(let networkFailureError):
                        let networkError = NetworkError(message: networkFailureError)
                        completion(.failure(networkError))
                }
            }
        }
    }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> ResponseResult<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
