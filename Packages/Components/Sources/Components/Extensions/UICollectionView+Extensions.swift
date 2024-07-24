//
//  UICollectionView+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit

extension UICollectionView {
    // Registers a cell class with the collection view
    public func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = cellType.className
        self.register(cellType, forCellWithReuseIdentifier: className)
    }

    // Dequeues a reusable cell of the specified type
    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
        return cell
    }
}
