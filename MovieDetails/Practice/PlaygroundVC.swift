//
//  PlaygroundVC.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 28/07/24.
//

import Foundation
import UIKit
import SnapKit

final class PlaygroundVC: UIViewController {

    private let boxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    private var bottomConstraint: NSLayoutConstraint?
    private var bottomSnpConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doSomeAnimation()
    }

}

private extension PlaygroundVC {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        view.addSubviews(boxView)
    }

    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            boxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            boxView.widthAnchor.constraint(equalToConstant: 100),
//            boxView.heightAnchor.constraint(equalToConstant: 100),
//        ])
//        bottomConstraint = boxView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//        bottomConstraint?.isActive = true

//         SnapKit
                boxView.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.width.height.equalTo(100)
                    bottomSnpConstraint = make.bottom.equalToSuperview().constraint
                }
    }

    func setupListeners() {}

    func doSomeAnimation() {
        let finalBottomInset = UIScreen.main.bounds.height - 200
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: [.repeat, .autoreverse]
        ) { [weak self] in
//            self?.bottomConstraint?.constant = -finalBottomInset
            self?.bottomSnpConstraint?.update(inset: finalBottomInset)
            self?.view.layoutIfNeeded()
        }
    }
}
