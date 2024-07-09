//
//  DetailsViewController.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import CommonUtils

final class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    private let presenter: DetailsPresenterProtocol

    private let headerView = SectionHeaderView()

    private let loadingView: BasicLoaderView = {
        let view = BasicLoaderView()
        view.isHidden = true
        return view
    }()

    private let errorView: BasicErrorView = {
        let view = BasicErrorView()
        view.isHidden = true
        return view
    }()

    private let disposeBag = DisposeBag()

    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        presenter.input.viewLoaded.onNext(())
    }
}

private extension DetailsViewController {
    func setupUI() {
        view.backgroundColor = CommonColors.pureWhite
        addSubViews()
        setupConstraints()
        setupViews()
    }

    func addSubViews() {
        view.addSubviews(headerView,
                         loadingView,
                         errorView)
    }

    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        loadingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        errorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

    func setupBindings() {
        presenter.output.showLoader
            .drive(onNext: { [weak self] showLoader in
                self?.setFullScreenState(state: showLoader ? .loading : .loaded)
            }).disposed(by: disposeBag)

        presenter.output.showError
            .drive(onNext: { [weak self] _ in
                self?.setFullScreenState(state: .error("Something Went Wrong"))
            }).disposed(by: disposeBag)

        presenter.output.setupViews
            .drive(onNext: { [weak self] _ in
                self?.setupViews()
            }).disposed(by: disposeBag)
    }

    func setupViews() {
        let headerText = presenter.headerText()
        headerView.config(text: headerText)
    }
}

private extension DetailsViewController {
    func setFullScreenState(state: FullScreenStates) {
        let hideLoadingView: Bool
        let hideErrorView: Bool
        switch state {
            case .loaded:
                hideLoadingView = true
                hideErrorView = true
            case .loading:
                hideLoadingView = false
                hideErrorView = true
            case .error(_):
                hideLoadingView = true
                hideErrorView = false
        }
        errorView.isHidden = hideErrorView
        loadingView.isHidden = hideLoadingView
    }
}

// any methods that can be exposed to router via DetailsViewControllerProtocol
extension DetailsViewController {
    func popOrDismiss() {
        // do any other heavy lifting if needed
        dismiss(animated: true)
    }
}
