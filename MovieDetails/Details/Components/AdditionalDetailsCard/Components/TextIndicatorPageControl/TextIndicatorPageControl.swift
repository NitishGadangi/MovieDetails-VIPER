//
//  TextIndicatorPageControl.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import SnapKit
import CommonUtils

final class TextIndicatorPageControl: UIView, ReusableView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = false
        view.register(TextIndicatorItemCell.self)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = false
        view.bounces = false
        return view
    }()

    private let borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = CommonColors.lightGrey
        return view
    }()

    private(set) var currentPage: Int = 0

    private var viewModel: AdditionalDetailsCardViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }

    weak var delegate: TextPageControlDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func selectPage(index: Int) {
        collectionView.reloadData()
        currentPage = index
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let indexPath = IndexPath(row: index, section: 0)
            self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    func configure(viewModel: AdditionalDetailsCardViewModel) {
        self.viewModel = viewModel
    }
}

private extension TextIndicatorPageControl {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        addSubviews(collectionView, borderLine)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.top.bottom.equalToSuperview()
        }

        borderLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }

    func setupListeners() {
        collectionView.contentInset.left = 16
        collectionView.contentInset.right = 16
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TextIndicatorPageControl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.model?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TextIndicatorItemCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let isSelected = indexPath.row == currentPage
        if let header = viewModel?.headerAt(index: indexPath.row) {
            cell.wrappedView.config(text: header, isSelected: isSelected)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 48)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectPage(index: indexPath.row)
    }
}

protocol TextPageControlDelegate: AnyObject {
    func didSelectPage(index: Int)
}
