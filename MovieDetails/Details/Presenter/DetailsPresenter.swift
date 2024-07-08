//
//  DetailsPresenter.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsPresenter: DetailsPresenterProtocol {
    let input: DetailsPresenterInput
    let output: DetailsPresenterOutput

    // Inputs
    private let viewLoaded = PublishSubject<Void>()

    // Outputs
    private let showLoader = PublishRelay<Bool>()

    private let disposeBag = DisposeBag()

    private let router: DetailsRouterProtocol
    private let interactor: DetailsInteractorProtocol

    init(interactor: DetailsInteractorProtocol, router: DetailsRouterProtocol) {
        self.input = DetailsPresenterInput(viewLoaded: viewLoaded)
        self.output = DetailsPresenterOutput(showLoader: showLoader)
        self.interactor = interactor
        self.router = router
        setupBindings()
    }
}

private extension DetailsPresenter {
    func setupBindings() {
        viewLoaded.subscribe(onNext: { [weak self] _ in
            self?.interactor.input.fetchData.onNext(())
        }).disposed(by: disposeBag)

        interactor.output.dataFetchInProgress.subscribe(onNext: {[weak self] isLoading in
            self?.showLoader.accept(isLoading)
        }).disposed(by: disposeBag)
    }
}
