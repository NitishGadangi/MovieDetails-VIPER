//
//  TabBarItemVC.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation
import UIKit
import SnapKit

final class TabBarItemVC: UIViewController {

    private let label: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .heavy)
        view.textColor = .black
        return view
    }()

    private let text: String

    init(text: String) {
        self.text = text
        label.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension TabBarItemVC {
    func setupUI() {
        addSubViews()
        setupConstraints()
        setupListeners()
    }

    func addSubViews() {
        view.addSubviews(label)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    func setupListeners() {}
}
