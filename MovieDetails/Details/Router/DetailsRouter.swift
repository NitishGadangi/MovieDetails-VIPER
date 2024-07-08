//
//  DetailsRouter.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

final class DetailsRouter: DetailsRouterProtocol {
    weak var viewController: (any DetailsViewControllerProtocol)?

    func navigateBack() {
        viewController?.popOrDismiss()
    }
}
