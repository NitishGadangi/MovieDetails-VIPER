//
//  AdditionalDetailsCardViewModel.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 10/07/24.
//

import Foundation
import CommonUtils

final class AdditionalDetailsCardViewModel: ViewModellable {
    typealias DataModel = [AdditionalInfoItem]?

    let model: [AdditionalInfoItem]?

    init(model: [AdditionalInfoItem]?) {
        self.model = model
    }

    func headerAt(index: Int) -> String? {
        return model?[safe: index]?.header
    }

    func bodyAt(index: Int) -> String? {
        return model?[safe: index]?.body
    }
}
