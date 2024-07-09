//
//  AdditionalDetailsItemView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

typealias AdditionalDetailsCell = AnyCollectionViewCell<AdditionalDetailsItemView>

final class AdditionalDetailsItemView: UIView, ReusableView {
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = CommonFonts.sfRegular16
        view.textColor = CommonColors.flatGrey
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
}

private extension AdditionalDetailsItemView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubview(label)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CommonInsets.leftPadding)
            make.top.bottom.equalToSuperview().inset(12)
        }
    }
}
