//
//  SectionHeaderView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import SnapKit

final class SectionHeaderView: UIView {
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = CommonFonts.sfBold18
        view.textColor = CommonColors.darkBlack
        view.textAlignment = .left
        return view
    }()

    private let borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = CommonColors.lightGrey
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

    func config(text: String?) {
        label.text = text
    }
}

private extension SectionHeaderView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(label, borderLine)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CommonInsets.leftPadding)
            make.top.equalToSuperview().inset(SizeConstants.labelTopBottom)
        }

        borderLine.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(SizeConstants.labelTopBottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

extension SectionHeaderView {
    struct SizeConstants {
        static var labelTopBottom: CGFloat { 18 }
    }
}
