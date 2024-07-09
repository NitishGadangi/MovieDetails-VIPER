//
//  DetailsViewController.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import UIKit
import SnapKit

final class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    private let presenter: DetailsPresenterProtocol

    private let headerView = SectionHeaderView()

    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CommonColors.pureWhite
        setupUI()
        setupBindings()
        presenter.input.viewLoaded.onNext(())
    }
}

private extension DetailsViewController {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupViews()
    }

    func addSubViews() {
        view.addSubviews(headerView)
    }

    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }

    func setupViews() {
        headerView.config(text: "Section Title")
    }

    func setupBindings() {}
}

// any methods that can be exposed to router via DetailsViewControllerProtocol
extension DetailsViewController {
    func popOrDismiss() {
        // do any other heavy lifting if needed
        dismiss(animated: true)
    }
}
