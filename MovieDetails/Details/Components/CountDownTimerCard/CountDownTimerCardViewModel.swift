//
//  CountDownTimerCardViewModel.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 10/07/24.
//

import Foundation
import CommonUtils

final class CountDownTimerCardViewModel: ViewModellable {
    typealias DataModel = CountDownTimerTemplateProperties

    let model: CountDownTimerTemplateProperties

    init(model: CountDownTimerTemplateProperties) {
        self.model = model
    }
}
