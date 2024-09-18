//
//  VCTransitionsVC.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 28/07/24.
//

import Foundation
import UIKit

final class VCTransitionsVC: UIViewController {

    private let presentationAnimator = CustomPresentAnimator(duration: 1)
    private let dismissAnimator = CustomDismissAnimator(duration: 1)

    private let button: UIButton = {
        let view = UIButton()
        view.setTitle("start_transition", for: .normal)
        return view
    }()

    private let boxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupUI()
    }
}

private extension VCTransitionsVC {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        view.addSubviews(boxView, button)
    }

    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(250)
        }

        boxView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview().offset(100)
            make.width.height.equalTo(100)
        }
    }

    func setupListeners() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        navigationController?.delegate = self
        navigationController?.isNavigationBarHidden = true
    }

    @objc func buttonTapped() {
        pushOrPop()
    }

    func pushOrPop() {
        let nextView = AnimationsVC()
        self.navigationController?.pushViewController(nextView, animated: true)
    }

    func presentVC() {
        let nextView = AnimationsVC()
        nextView.modalPresentationStyle = .fullScreen
        nextView.transitioningDelegate = self
        self.present(nextView, animated: true)
    }
}

extension VCTransitionsVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return presentationAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return dismissAnimator
    }
}

extension VCTransitionsVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        switch operation {
            case .push:
                return presentationAnimator
            case .pop:
                return dismissAnimator
            default:
                return nil
        }
    }
}

