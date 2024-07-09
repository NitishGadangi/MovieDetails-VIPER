//
//  DetailsInteractorIO.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation

import RxCocoa
import RxSwift

struct DetailsInteractorInput {
    let fetchData: AnyObserver<Void>

    init(fetchData: PublishSubject<Void>) {
        self.fetchData = fetchData.asObserver()
    }
}

struct DetailsInteractorOutput {
    let dataFetchInProgress: Observable<Bool>
    let dataReceived: Observable<DetailsResponseModel>
    let didFailToFetchData: Observable<ErrorInfo>

    init(dataFetchInProgress: PublishRelay<Bool>,
         dataReceived: PublishRelay<DetailsResponseModel>,
         didFailToFetchData: PublishRelay<ErrorInfo>) {
        self.dataFetchInProgress = dataFetchInProgress.asObservable()
        self.dataReceived = dataReceived.asObservable()
        self.didFailToFetchData = didFailToFetchData.asObservable()
    }
}

protocol DetailsInteractorIO {
    var input: DetailsInteractorInput { get }
    var output: DetailsInteractorOutput { get }
}

protocol DetailsInteractorDataProvider {
    func getDataModel() -> DetailsResponseModel?
}

protocol DetailsEventLogger {
    // log any analytcics events from presenter via interactor
}

typealias DetailsInteractorProtocol = DetailsInteractorIO & DetailsInteractorDataProvider & DetailsEventLogger
