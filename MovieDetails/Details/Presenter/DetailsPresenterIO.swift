//
//  DetailsPresenterIO.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import CommonUtils
import RxCocoa
import RxSwift

struct DetailsPresenterInput {
    let viewLoaded: AnyObserver<Void>

    init(viewLoaded: PublishSubject<Void>) {
        self.viewLoaded = viewLoaded.asObserver()
    }
}

struct DetailsPresenterOutput {
    let showLoader: Driver<Bool>

    init(showLoader: PublishRelay<Bool>) {
        self.showLoader = showLoader.asDriverOrEmpty()
    }
}

protocol DetailsPresenterIO {
    var input: DetailsPresenterInput { get }
    var output: DetailsPresenterOutput { get }
}

protocol DetailsPresenterDataProvider {
    // add funcs to provide data to view controller on demand
}

typealias DetailsPresenterProtocol = DetailsPresenterIO & DetailsPresenterDataProvider
