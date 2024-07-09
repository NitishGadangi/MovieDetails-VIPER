//
//  BasicErrorView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import SnapKit

// basic implementation of a Error State
// This can be extended further if needed
final class BasicErrorView: UIView {
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = CommonFonts.sfMedium16
        view.textColor = CommonColors.darkGrey
        view.textAlignment = .center
        view.text = "Oops! Something Went Wrong!!"
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

private extension BasicErrorView {
    func setupUI() {
        backgroundColor = CommonColors.pureWhite
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubview(label)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CommonInsets.leftPadding)
            make.top.bottom.equalToSuperview().inset(100)
        }
    }
}
