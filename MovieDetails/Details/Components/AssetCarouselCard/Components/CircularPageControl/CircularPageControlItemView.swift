//
//  CircularPageControlItemView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

final class CircularPageControlItemView: UIView {

    private let dotView: UIView = {
        let view = UIView()
        view.backgroundColor = CommonColors.dullGrey
        return view
    }()

    var isSelected: Bool = false {
        didSet {
            dotView.backgroundColor = isSelected ? CommonColors.specialRed : CommonColors.dullGrey
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

private extension CircularPageControlItemView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubview(dotView)
    }

    func setupConstraints() {
        dotView.snp.makeConstraints { make in
            make.height.width.equalTo(6)
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
