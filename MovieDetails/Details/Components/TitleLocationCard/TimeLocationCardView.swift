//
//  TimeLocationCard.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

typealias TimeLocationCell = AnyCollectionViewCell<TimeLocationCardView>

final class TimeLocationCardView: UIView, ReusableView {

    private let specialTag = SpecialTagView()

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = CommonFonts.sfBold20
        view.textColor = CommonColors.flatBlack
        return view
    }()

    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = CommonFonts.sfMedium16
        view.textColor = CommonColors.darkGrey
        return view
    }()

    private let locationView = ImageTextView()

    private let dateTimeView = ImageTextView()

    private var viewModel: TimeLocationCardViewModel? {
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

    func config(viewModel: TimeLocationCardViewModel) {
        self.viewModel = viewModel
    }
}

private extension TimeLocationCardView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(specialTag,
                    titleLabel,
                    descriptionLabel,
                    locationView,
                    dateTimeView)
    }

    func setupConstraints() {
        specialTag.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(specialTag.snp.bottom).offset(SizeConstants.titleTop)
            make.leading.trailing.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(SizeConstants.descTop)
            make.leading.trailing.equalToSuperview()
        }

        locationView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(SizeConstants.locationTop)
            make.leading.trailing.equalToSuperview()
        }

        dateTimeView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom).offset(SizeConstants.dateTimeTop)
            make.leading.trailing.equalToSuperview()
        }
    }

    func setupViews() {
        specialTag.config(text: viewModel?.model.tag)
        titleLabel.text = viewModel?.model.title
        descriptionLabel.text = viewModel?.model.subTitle
        let locationModel = viewModel?.model.location
        locationView.config(imgUrl: locationModel?.asset?.url, text: locationModel?.text)
        let dateTimeModel = viewModel?.model.dateTime
        dateTimeView.config(imgUrl: dateTimeModel?.asset?.url, text: dateTimeModel?.text)
    }
}

extension TimeLocationCardView {
    struct SizeConstants {
        static var titleTop: CGFloat { 10 }
        static var descTop: CGFloat { 5 }
        static var locationTop: CGFloat { 12 }
        static var dateTimeTop: CGFloat { 8 }
    }
}
