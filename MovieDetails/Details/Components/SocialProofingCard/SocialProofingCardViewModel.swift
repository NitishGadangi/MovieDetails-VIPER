//
//  SocialProofingCardViewModel.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 10/07/24.
//

import Foundation
import CommonUtils

final class SocialProofingCardViewModel: ViewModellable {
    typealias DataModel = SocialProofingTemplateProperties

    let model: SocialProofingTemplateProperties

    init(model: SocialProofingTemplateProperties) {
        self.model = model
    }
}
