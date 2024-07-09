//
//  TimerTextView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import SnapKit
import CommonUtils

final class TimerTextView: UIView {
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textColor = CommonColors.specialRed
        return view
    }()

    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = CommonColors.veryLightGrey
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
        wrapperView.layer.cornerRadius = 6
    }

    func config(timeStamp: Double) {
        setupLabel(epoch: timeStamp)
    }
}

private extension TimerTextView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(wrapperView)
        wrapperView.addSubviews(label)
    }

    func setupConstraints() {
        wrapperView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }

        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }

    func setupLabel(epoch: TimeInterval) {
        let countDownTime = DateTimeUtils.timeUntilEpoch(epochTimestamp: epoch)
        let attrText = getAttrTimeString(time: countDownTime.days)
        attrText.append(getAttrTimeDescString(text: "Days"))

        attrText.append(getAttrTimeString(time: countDownTime.hours))
        attrText.append(getAttrTimeDescString(text: "Hours"))

        attrText.append(getAttrTimeString(time: countDownTime.minutes))
        attrText.append(getAttrTimeDescString(text: "Mins"))

        attrText.append(getAttrTimeString(time: countDownTime.seconds))
        attrText.append(getAttrTimeDescString(text: "Secs"))

        label.attributedText = attrText
    }

    func getAttrTimeString(time: Int) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: "\(time)",
            attributes: [NSAttributedString.Key.font: CommonFonts.sfSemiBold20]
        )
    }

    func getAttrTimeDescString(text: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: " \(text)   ",
            attributes: [NSAttributedString.Key.font: CommonFonts.sfSemiBold12]
        )
    }
}
