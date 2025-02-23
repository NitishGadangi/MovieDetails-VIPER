//
//  AnimationsVC.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 28/07/24.
//

import Foundation
import UIKit
import SnapKit

final class AnimationsVC: UIViewController {

    private let button: UIButton = {
        let view = UIButton()
        view.setTitle("dismiss", for: .normal)
        return view
    }()

    private let boxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.isHidden = true
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "dog_1")
        return view
    }()

    private let label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "ONE"
        view.font = .systemFont(ofSize: 20, weight: .heavy)
        view.backgroundColor = .gray
        return view
    }()

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

private extension AnimationsVC {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        view.addSubviews(boxView, imageView, label, button)
    }

    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(50)
        }

        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }

        boxView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.width.height.equalTo(100)
        }
    }

    func setupListeners() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {
//        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }

    func doSomeAnimation() {
        fashSwitchLabels()
    }

    func fashSwitchLabels() {
        let dummyLabel = UILabel()
        dummyLabel.text = "TWO"
        dummyLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        dummyLabel.backgroundColor = .gray
        dummyLabel.textAlignment = .center
        dummyLabel.frame = label.frame

        let offset = CGPoint(x: -label.frame.origin.x, y: 0)
        let offsetTransform = CGAffineTransform(translationX: offset.x, y: offset.y)
        dummyLabel.transform = offsetTransform
        dummyLabel.alpha = 0
        view.addSubview(dummyLabel)

        // dummy label in
        UIView.animate(withDuration: 1, delay: 0) {
            dummyLabel.transform = .identity
            dummyLabel.alpha = 1
        }

        //original label out
        UIView.animate(withDuration: 0.5, delay: 0.5) { [weak self] in
            self?.label.transform = offsetTransform
            self?.label.alpha = 0
        } completion: { _ in
            //
        }
    }

    func scaleImage() {
        UIView.animate(withDuration: 2, delay: 1) { [weak self] in
            self?.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }

    func imageFadeOutFadeIn() {
        UIView.animate(withDuration: 2, delay: 1, options: [.curveLinear]) { [weak self] in
//            self?.imageView.alpha = 0
            self?.imageView.image = UIImage(named: "dog_2")
//            self?.imageView.alpha = 1
        }
    }

    func animateFadeOut() {
        UIView.animate(withDuration: 2, delay: 1) { [weak self] in
            self?.boxView.alpha = 0
        }
    }

    func springAnimation() {
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
