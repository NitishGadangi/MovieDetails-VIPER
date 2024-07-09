//
//  EmptyCollectionView.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 10/07/24.
//

import Foundation
import UIKit
import CommonUtils

typealias EmptyCell = AnyCollectionViewCell<EmptyCollectionViewCell>

final class EmptyCollectionViewCell: UIView, ReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
