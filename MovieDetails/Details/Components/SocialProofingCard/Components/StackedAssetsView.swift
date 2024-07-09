//
//  StackedAssetsView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

final class StackedAssetsView: UIView {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = -8
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func config(assets: [GenericAsset]) {
        addAssetsToStack(assets: assets)
    }
}

private extension StackedAssetsView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(stackView)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }

    func addAssetsToStack(assets: [GenericAsset]) {
        for asset in assets {
            let circularImage = CircularImageView()
            circularImage.config(imgUrl: asset.url)
            stackView.addArrangedSubview(circularImage)
        }
    }
}
