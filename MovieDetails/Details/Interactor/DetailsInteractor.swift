//
//  DetailsInteractor.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsInteractor: DetailsInteractorProtocol {
    
    let input: DetailsInteractorInput
    let output: DetailsInteractorOutput

    // Inputs
    private let fetchData = PublishSubject<Void>()

    // Outputs
    private let dataFetchInProgress = PublishRelay<Bool>()
    private let dataReceived = PublishRelay<DetailsResponseModel>()
    private let didFailToFetchData = PublishRelay<ErrorInfo>()

    private let disposeBag = DisposeBag()
    private var detailsModel: DetailsResponseModel?

    private let repository: DetailsRepositoryProtocol

    init(repository: DetailsRepositoryProtocol) {
        self.input = DetailsInteractorInput(fetchData: fetchData)
        self.output = DetailsInteractorOutput(
            dataFetchInProgress: dataFetchInProgress,
            dataReceived: dataReceived,
            didFailToFetchData: didFailToFetchData
        )
        self.repository = repository
        // rx bindings
        setupBindings()
    }
}

private extension DetailsInteractor {
    func setupBindings() {
        fetchData.subscribe(onNext: { [weak self] in
            self?.fetchMovieDetails()
        }).disposed(by: disposeBag)
    }

    func fetchMovieDetails() {
        dataFetchInProgress.accept(true)
        repository.getMovieDetails { [weak self] result in
            self?.dataFetchInProgress.accept(false)
            switch result {
                case .success(let model):
                    self?.detailsModel = model
                    self?.dataReceived.accept(model)
                case .failure(let error):
                    let errorInfo = ErrorInfo(message: error.localizedDescription)
                    self?.didFailToFetchData.accept(errorInfo)
            }
        }
    }
}

extension DetailsInteractor {
    func getDataModel() -> DetailsResponseModel? {
        return detailsModel
    }
}
