//
//  SpecialTagView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import SnapKit

final class SpecialTagView: UIView {
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = CommonFonts.sfBold12
        view.textColor = CommonColors.specialRed
        view.textAlignment = .left
        return view
    }()

    // add line with gradient

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

private extension SpecialTagView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(label)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview() // will be changed when line is addded
        }
    }
}
