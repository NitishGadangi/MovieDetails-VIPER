//
//  SocialProofingCardView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import CommonUtils
import SnapKit

final class SocialProofingCardView: UIView, ReusableView {
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textColor = CommonColors.flatGrey
        view.font = CommonFonts.sfRegular12
        return view
    }()

    private let stackedImageView = StackedAssetsView()

    private var viewModel: SocialProofingCardViewModel? {
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

    func config(viewModel: SocialProofingCardViewModel) {
        self.viewModel = viewModel
    }
}

private extension SocialProofingCardView {
    func setupUI() {
        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubviews(stackedImageView, descriptionLabel)
    }

    func setupConstraints() {
        stackedImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(stackedImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func setupViews() {
        stackedImageView.config(assets: viewModel?.model.assets ?? [])
        setupDescriptionLabel()
    }

    func setupDescriptionLabel() {
        let attrText = NSMutableAttributedString(string: "Till now")
        attrText.append(getAttrBoldString(text: " 10,000+ Users "))
        attrText.append(NSAttributedString(string: "have already booked tickets."))
        descriptionLabel.attributedText = attrText
    }

    func getAttrBoldString(text: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.font: CommonFonts.sfBold12]
        )
    }

    func getAttrDescString(text: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text)
    }
}
