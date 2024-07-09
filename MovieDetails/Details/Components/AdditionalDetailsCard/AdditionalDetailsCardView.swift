//
//  AdditionalDetailsCardView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import SnapKit
import CommonUtils

typealias AdditionalDetailsCardCell = AnyCollectionViewCell<AdditionalDetailsCardView>

final class AdditionalDetailsCardView: UIView, ReusableView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.register(AdditionalDetailsCell.self)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = false
        view.bounces = false
        return view
    }()

    private let pageControl = TextIndicatorPageControl()

    private var viewModel: AdditionalDetailsCardViewModel? {
        didSet {
            setupViews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func config(viewModel: AdditionalDetailsCardViewModel) {
        self.viewModel = viewModel
    }
}

private extension AdditionalDetailsCardView {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        addSubviews(pageControl, collectionView)
    }

    func setupConstraints() {
        pageControl.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func setupListeners() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setupViews() {
        guard let viewModel else { return }
        pageControl.configure(viewModel: viewModel)
        collectionView.reloadData()
    }
}

extension AdditionalDetailsCardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.model?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AdditionalDetailsCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if let bodyText = viewModel?.bodyAt(index: indexPath.row) {
            cell.wrappedView.config(text: bodyText)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CommonInsets.screenWidth
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle any CTAs if needed
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let numberOfPages = collectionView.numberOfItems(inSection: 0)
        guard numberOfPages > 0 else { return }
        let eachPageSize = scrollView.contentSize.width / CGFloat(numberOfPages)
        guard eachPageSize > 0 else { return }
        var curIndex = Int(ceil(scrollView.contentOffset.x/eachPageSize)) % numberOfPages
        curIndex = max(0, curIndex)
        if pageControl.currentPage != curIndex {
            pageControl.selectPage(index: curIndex)
        }
    }
}


extension AdditionalDetailsCardView: TextPageControlDelegate {
    func didSelectPage(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
