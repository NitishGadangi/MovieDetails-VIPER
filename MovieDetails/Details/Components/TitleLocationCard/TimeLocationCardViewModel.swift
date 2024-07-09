//
//  TimeLocationCardViewModel.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 10/07/24.
//

import Foundation
import CommonUtils

final class TimeLocationCardViewModel: ViewModellable {
    typealias DataModel = TitleLocationTemplateProperties

    let model: TitleLocationTemplateProperties

    init(model: TitleLocationTemplateProperties) {
        self.model = model
    }
}
