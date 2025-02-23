//
//  TransitionsVC.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 28/07/24.
//

import Foundation
import UIKit
import SnapKit

final class TransitionsVC: UIViewController {

    private let greenBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    private let purbleBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        return view
    }()

    private let containerView = UIView()

    private var bottomSnpConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doTransitions()
    }
}

private extension TransitionsVC {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        view.addSubview(containerView)
        containerView.addSubviews(greenBox, purbleBox)
    }

    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }

        greenBox.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        purbleBox.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    func setupListeners() {}

    func doTransitions() {
        UIView.transition(from: purbleBox, to: greenBox, duration: 5, options: [.transitionFlipFromTop, .showHideTransitionViews, .repeat, .autoreverse])
    }

    func doSomeAnimation() {
        let finalBottomInset = UIScreen.main.bounds.height - 200
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: [.repeat, .autoreverse]
        ) { [weak self] in
            self?.bottomSnpConstraint?.update(inset: finalBottomInset)
            self?.view.layoutIfNeeded()
        }
    }
}

