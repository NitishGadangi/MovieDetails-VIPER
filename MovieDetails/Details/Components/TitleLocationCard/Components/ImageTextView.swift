//
//  ImageTextView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import SnapKit
import CommonUtils

final class ImageTextView: UIView {
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = CommonFonts.sfMedium14
        view.textColor = CommonColors.flatGrey
        view.textAlignment = .left
        return view
    }()

    private let startImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
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

    func config(imgUrl: String?, text: String?) {
        label.text = text
        startImage.loadImage(fromUrl: imgUrl)
    }
}

private extension ImageTextView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(startImage, label)
    }

    func setupConstraints() {
        startImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(SizeConstants.imageWidth)
            make.height.equalTo(SizeConstants.imageHeight)
        }

        label.snp.makeConstraints { make in
            make.leading.equalTo(startImage.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}

extension ImageTextView {
    struct SizeConstants {
        static var imageWidth: CGFloat { 17 }
        static var imageHeight: CGFloat { imageWidth }
    }
}

