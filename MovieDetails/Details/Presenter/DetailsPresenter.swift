//
//  DetailsPresenter.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import RxSwift
import RxCocoa
import CommonUtils

final class DetailsPresenter: DetailsPresenterProtocol {
    let input: DetailsPresenterInput
    let output: DetailsPresenterOutput

    // Inputs
    private let viewLoaded = PublishSubject<Void>()

    // Outputs
    private let showLoader = PublishRelay<Bool>()
    private let showError = PublishRelay<Void>()
    private let setupViews = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    private let router: DetailsRouterProtocol
    private let interactor: DetailsInteractorProtocol

    init(interactor: DetailsInteractorProtocol, router: DetailsRouterProtocol) {
        self.input = DetailsPresenterInput(viewLoaded: viewLoaded)
        self.output = DetailsPresenterOutput(showLoader: showLoader,
                                             showError: showError,
                                             setupViews: setupViews)
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

        interactor.output.dataReceived.subscribe(onNext: {[weak self] _ in
            self?.setupViews.accept(())
        }).disposed(by: disposeBag)

        interactor.output.didFailToFetchData.subscribe(onNext: {[weak self] _ in
            self?.showError.accept(())
        }).disposed(by: disposeBag)
    }
}

extension DetailsPresenter {
    func numberOfTemplateItems() -> Int {
        let model = interactor.getDataModel()
        return model?.items?.count ?? 0
    }

    func templateTypeForItemAt(index: Int) -> DetailsTemplateType {
        let model = interactor.getDataModel()
        let templateModel = model?.items?[safe: index]
        return templateModel?.templateType ?? .unknown
    }

    func modelForItemAt(index: Int) -> (any ViewModellable)? {
        let model = interactor.getDataModel()
        let templateModel = model?.items?[safe: index]
        switch templateModel {
            case .assetCarouselCard(let model):
                return AssetCarouselCardViewModel(model: model)
            case .titleLocationCard(let model):
                return TimeLocationCardViewModel(model: model)
            case .countdownTimerCard(let model):
                return CountDownTimerCardViewModel(model: model)
            case .socialProofingCard(let model):
                return SocialProofingCardViewModel(model: model)
            case .additionalDetailsCard(let model):
                return AdditionalDetailsCardViewModel(model: model.details)
            default:
                return nil
        }
    }

    func sizeForItemAt(index: Int) -> CGSize {
        let width = CommonInsets.screenWidth
        let templateType = templateTypeForItemAt(index: index)
        let height: CGFloat
        switch templateType {
            case .assetCarouselCard:
                height = AssetCarouselCardView.SizeConstants.height
            case .titleLocationCard:
                height = TimeLocationCardView.SizeConstants.height
            case .countdownTimerCard:
                height = CountDownTimerCardView.SizeConstants.height
            case .socialProofingCard:
                height = SocialProofingCardView.SizeConstants.height
            case .additionalDetailsCard:
                height = 800
            case .unknown:
                height = 0
        }
        return CGSize(width: width, height: height)
    }

    func headerText() -> String? {
        let model = interactor.getDataModel()
        return model?.header
    }
}
