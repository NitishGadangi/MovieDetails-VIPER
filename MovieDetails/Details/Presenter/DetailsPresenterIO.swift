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
    let showError: Driver<Void>
    let setupViews: Driver<Void>

    init(showLoader: PublishRelay<Bool>,
         showError: PublishRelay<Void>,
         setupViews: PublishRelay<Void>) {
        self.showLoader = showLoader.asDriverOrEmpty()
        self.showError = showError.asDriverOrEmpty()
        self.setupViews = setupViews.asDriverOrEmpty()
    }
}

protocol DetailsPresenterIO {
    var input: DetailsPresenterInput { get }
    var output: DetailsPresenterOutput { get }
}

protocol DetailsPresenterDataProvider {
    func numberOfTemplateItems() -> Int
    func templateTypeForItemAt(index: Int) -> DetailsTemplateType
    func modelForItemAt(index: Int) -> (any ViewModellable)?
    func sizeForItemAt(index: Int) -> CGSize
    func headerText() -> String?
    func indexPathForStickyHeader() -> IndexPath?
    func getStickyPageControlViewModel() -> AdditionalDetailsCardViewModel?
}

typealias DetailsPresenterProtocol = DetailsPresenterIO & DetailsPresenterDataProvider
