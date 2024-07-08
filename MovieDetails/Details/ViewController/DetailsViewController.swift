//
//  DetailsViewController.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import UIKit

final class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    private let presenter: DetailsPresenterProtocol

    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        presenter.input.viewLoaded.onNext(())
    }
}

extension DetailsViewController {
    func popOrDismiss() {
        // do any other heavy lifting if needed
        dismiss(animated: true)
    }
}

private extension DetailsViewController {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupViews()
    }

    func addSubViews() {}

    func setupConstraints() {}

    func setupViews() {}

    func setupBindings() {}
}
