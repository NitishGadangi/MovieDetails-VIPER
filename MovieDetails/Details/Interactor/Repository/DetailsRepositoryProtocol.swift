//
//  DetailsRepositoryProtocol.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import NetworkCore

protocol DetailsRepositoryProtocol {
    func getMovieDetails(completion: @escaping (Result<DetailsResponseModel, NetworkError>) -> Void)
}
