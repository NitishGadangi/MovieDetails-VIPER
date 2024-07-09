//
//  AssetCarouselCardViewModel.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 10/07/24.
//

import Foundation
import CommonUtils

final class AssetCarouselCardViewModel: ViewModellable {
    typealias DataModel = AssetCarouselTemplateProperties

    let model: AssetCarouselTemplateProperties

    init(model: AssetCarouselTemplateProperties) {
        self.model = model
    }

    func assetUrlAt(index: Int) -> String? {
        return model.assets?[safe: index]?.url
    }
}
