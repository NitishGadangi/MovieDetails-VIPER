//
//  DetailsRouterProtocol.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

protocol DetailsRouterProtocol {
    var viewController: DetailsViewControllerProtocol? { get set }

    func navigateBack()
}
