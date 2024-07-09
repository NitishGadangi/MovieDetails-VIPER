//
//  CircularCornersAssetView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

typealias CircularCornersAssetCell = AnyCollectionViewCell<CircularCornersAssetView>

final class CircularCornersAssetView: UIView, ReusableView {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 10
    }

    func config(imgUrl: String?) {
        imageView.loadImage(fromUrl: imgUrl)
    }
}

private extension CircularCornersAssetView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubview(imageView)
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(SizeConstants.imageWidth)
            make.height.equalTo(SizeConstants.imageHeight)
        }
    }
}

extension CircularCornersAssetView {
    struct SizeConstants {
        static var screenWidth: CGFloat { UIScreen.main.bounds.width }
        static var imageAspectRatio: CGFloat { 1.33 }
        static var imageWidth: CGFloat { screenWidth - 16 - 31 } // left & right padding
        static var imageHeight: CGFloat { imageWidth/imageAspectRatio }
    }
}
