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

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = false
        view.register(AdditionalDetailsCardCell.self)
        view.register(SocialProofingCell.self)
        view.register(CountDownTimerCell.self)
        view.register(TimeLocationCell.self)
        view.register(AssetCarouselCell.self)
        view.register(EmptyCell.self)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.bounces = false
        return view
    }()

    private let stickyPageControl: TextIndicatorPageControl = {
        let view = TextIndicatorPageControl()
        view.isHidden = true
        return view
    }()

    private var isStickyPageControlConfigured: Bool = false

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
        setupListeners()
        setupViews()
    }

    func addSubViews() {
        view.addSubviews(headerView,
                         collectionView,
                         stickyPageControl,
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

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        stickyPageControl.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.leading.equalToSuperview()
            make.width.equalToSuperview()
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

    func setupListeners() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.top = 16
    }

    func setupViews() {
        setFullScreenState(state: .loaded)
        let headerText = presenter.headerText()
        headerView.config(text: headerText)
        if let stickyHeaderViewModel = presenter.getStickyPageControlViewModel() {
            stickyPageControl.delegate = self
            stickyPageControl.configure(viewModel: stickyHeaderViewModel)
            isStickyPageControlConfigured = true
        } else {
            isStickyPageControlConfigured = false
        }
        collectionView.reloadData()
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

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfTemplateItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = presenter.modelForItemAt(index: indexPath.section)
        switch viewModel {
            case let viewModel as AssetCarouselCardViewModel:
                let cell: AssetCarouselCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.wrappedView.config(viewModel: viewModel)
                return cell
            case let viewModel as TimeLocationCardViewModel:
                let cell: TimeLocationCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.wrappedView.config(viewModel: viewModel)
                return cell
            case let viewModel as CountDownTimerCardViewModel:
                let cell: CountDownTimerCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.wrappedView.config(viewModel: viewModel)
                return cell
            case let viewModel as SocialProofingCardViewModel:
                let cell: SocialProofingCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.wrappedView.config(viewModel: viewModel)
                return cell
            case let viewModel as AdditionalDetailsCardViewModel:
                let cell: AdditionalDetailsCardCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.wrappedView.config(viewModel: viewModel)
                return cell
            default:
                let cell: EmptyCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(index: indexPath.section)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle any CTAs here
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if let indexPathForPageControl = presenter.indexPathForStickyHeader(),
           collectionView.indexPathsForVisibleItems.contains(indexPathForPageControl) {
            updateStickyPageControl()
        }
    }

    // logic to handle sticky header view
    func updateStickyPageControl() {
        guard let indexPath = presenter.indexPathForStickyHeader(),
              let layoutAttrForPageControl = collectionView.layoutAttributesForItem(at: indexPath),
              let collectionSuperView = collectionView.superview
        else { return }
        let cellFrameInSuperView = collectionView.convert(layoutAttrForPageControl.frame, to: collectionSuperView)
        let cellFrameInSuperViewMinY = cellFrameInSuperView.minY - view.safeAreaInsets.top - SectionHeaderView.SizeConstants.height
        let collectionSuperViewMinY = collectionSuperView.frame.minY
        let showPageControl = cellFrameInSuperViewMinY < collectionSuperViewMinY
        showStickyPageControl(showPageControl)
    }

    func showStickyPageControl(_ isVisible: Bool) {
        if isVisible && isStickyPageControlConfigured {
            stickyPageControl.isHidden = false
        } else {
            stickyPageControl.isHidden = true
        }
    }
}

extension DetailsViewController: TextPageControlDelegate {
    func didSelectPage(index: Int) {
        guard let indexPath = presenter.indexPathForStickyHeader(),
              let cell = collectionView.cellForItem(at: indexPath) as? AdditionalDetailsCardCell
        else { return }
        stickyPageControl.selectPage(index: index)
        cell.wrappedView.didSelectPage(index: index)
    }
}

// any methods that can be exposed to router via DetailsViewControllerProtocol
extension DetailsViewController {
    func popOrDismiss() {
        // do any other heavy lifting if needed
        dismiss(animated: true)
    }
}
