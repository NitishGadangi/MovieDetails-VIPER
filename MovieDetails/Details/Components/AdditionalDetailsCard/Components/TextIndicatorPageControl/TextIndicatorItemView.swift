//
//  TextIndicatorItemView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

typealias TextIndicatorItemCell = AnyCollectionViewCell<TextIndicatorItemView>

final class TextIndicatorItemView: UIView, ReusableView {
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = CommonFonts.sfMedium14
        view.textColor = CommonColors.flatGrey
        view.textAlignment = .center
        return view
    }()

    private let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = CommonColors.specialRed
        view.isHidden = true
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
        indicator.layer.cornerRadius = 1
        indicator.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func config(text: String?, isSelected: Bool) {
        label.text = text
        label.textColor = isSelected ? CommonColors.specialRed : CommonColors.flatGrey
        indicator.isHidden = isSelected == false
    }
}

private extension TextIndicatorItemView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(label, indicator)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }

        indicator.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
