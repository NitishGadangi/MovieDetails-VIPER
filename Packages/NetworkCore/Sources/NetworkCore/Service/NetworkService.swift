//
//  File.swift
//
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

class NetworkService<EndPoint: EndPointType>: NetworkServiceble {
    private let logger = NetworkLogger()
    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping NetworkServiceCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            logger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
              completion(data, response, error)
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // insert other cases here
        }
        return request
    }
}
