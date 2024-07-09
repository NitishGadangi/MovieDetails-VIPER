//
//  CircularPageControl.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils

final class CircularPageControl: UIView {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()

    private(set) var numberOfPills: Int = 0 {
        didSet {
            addPillsToStack(numberOfPills)
        }
    }

    var selectedPill: Int = 0 {
        didSet {
            updateSelectedPill(selectedPill)
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

    func config(count: Int, selectedIndex: Int = 0) {
        numberOfPills = count
        selectedPill = selectedIndex
    }
}

private extension CircularPageControl {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(stackView)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    func addPillsToStack(_ count: Int) {
        stackView.removeAllArrangedSubviews()
        for idx in 0..<count {
            let pageControlItem = CircularPageControlItemView()
            stackView.addArrangedSubview(pageControlItem)
            pageControlItem.isSelected = selectedPill == idx
        }
    }

    func updateSelectedPill(_ index: Int) {
        let stackViewItems = stackView.arrangedSubviews
        for (idx, pageControlItem) in stackViewItems.enumerated() {
            guard let pageControlItem = pageControlItem as? CircularPageControlItemView 
            else { continue }
            pageControlItem.isSelected = index == idx
        }
    }
}
