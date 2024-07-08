//
//  DetailsRepository.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import NetworkCore

class DetailsRepository: DetailsRepositoryProtocol {
    private let networkManager: NetworkManager<MoviesAPI>

    init(networkManager: NetworkManager<MoviesAPI> = .init(env: .stage)) {
        self.networkManager = networkManager
    }

    func getMovieDetails(completion: @escaping (Result<DetailsResponseModel, NetworkError>) -> Void) {
        networkManager.sendRequest(endPoint: .details, responseType: DetailsResponseModel.self) { result in
            switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
