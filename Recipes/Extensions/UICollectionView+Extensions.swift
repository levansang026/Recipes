//
//  UICollectionView+Extensions.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Generic function to dequeue cell
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        // swiftlint:disable force_cast
        return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
    
    /// Generic function to register cell
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType.self))
    }
}
