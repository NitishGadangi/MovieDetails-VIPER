//
//  AssetCarouselCardView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

final class AssetCarouselCardView: UIView, ReusableView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = false
        view.register(CircularCornersAssetCell.self)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = false
        view.bounces = false
        return view
    }()

    private let pageControl = CircularPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func reloadCollectionView() {
        pageControl.config(count: 3)
        collectionView.reloadData()
    }
}

private extension AssetCarouselCardView {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        addSubviews(collectionView, pageControl)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CircularCornersAssetView.SizeConstants.imageHeight)
        }

        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }

    func setupListeners() {
        collectionView.contentInset.left = CommonInsets.leftPadding
        collectionView.contentInset.right = CommonInsets.rightPadding
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension AssetCarouselCardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CircularCornersAssetCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CircularCornersAssetView.SizeConstants.imageWidth
        let height = CircularCornersAssetView.SizeConstants.imageHeight
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // do some action if needed
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let numberOfPages = pageControl.numberOfPills
        guard numberOfPages > 0 else { return }
        let eachPageSize = scrollView.contentSize.width / CGFloat(numberOfPages)
        guard eachPageSize > 0 else { return }
        var curIndex = Int(ceil(scrollView.contentOffset.x/eachPageSize)) % numberOfPages
        curIndex = max(0, curIndex)
        if pageControl.selectedPill != curIndex {
            pageControl.selectedPill = curIndex
        }
    }
}
