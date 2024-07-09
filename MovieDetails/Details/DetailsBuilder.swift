//
//  DetailsBuilder.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import UIKit
import NetworkCore
import CommonUtils

struct MovieDetailsBuilder: VIPERBaseBuilder {
    static func build() -> UIViewController {
        let networkManager = NetworkManager<MoviesAPI>(env: .stage)
        let repository = DetailsRepository(networkManager: networkManager) // mock repo can be injected if required
        let interactor = DetailsInteractor(repository: repository)
        let router = DetailsRouter()
        let presenter = DetailsPresenter(interactor: interactor, router: router)
        let viewController = DetailsViewController(presenter: presenter)
        router.viewController = viewController
        return viewController
    }
}
