//
//  CountDownTimerCardView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import CommonUtils
import UIKit
import SnapKit

typealias CountDownTimerCell = AnyCollectionViewCell<CountDownTimerCardView>

final class CountDownTimerCardView: UIView, ReusableView {
    private let topLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = CommonFonts.sfSemiBold12
        view.textColor = CommonColors.flatGrey
        return view
    }()

    private let timerLabel = TimerTextView()

    private var viewModel: CountDownTimerCardViewModel? {
        didSet {
            setupViews()
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

    func config(viewModel: CountDownTimerCardViewModel) {
        self.viewModel = viewModel
    }
}

private extension CountDownTimerCardView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(topLabel, timerLabel)
    }

    func setupConstraints() {
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    func setupViews() {
        topLabel.text = viewModel?.model.header
        if let endTime = viewModel?.model.endTime {
            timerLabel.config(timeStamp: endTime)
        }
    }
}

extension CountDownTimerCardView {
    struct SizeConstants {
        static var height: CGFloat { 15 + 8 + 45 + 10 }
    }
}
