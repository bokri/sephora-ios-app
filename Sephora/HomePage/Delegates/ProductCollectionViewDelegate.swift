//
//  ProductCollectionViewDelegate.swift
//  Sephora
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit
import SephoraBusiness

/// Handles user interactions with the collection view.
class ProductCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    /// Delegate for handling cell click events.
    private weak var delegate: HomePageDelegate?
    
    // MARK: - Method
    
    /// Sets up the delegate.
    /// - Parameter delegate: The delegate to be assigned.
    func setupDelegate(delegate: HomePageDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - UICollectionViewDelegate
    
    /// Notifies the delegate when a cell is selected.
    /// - Parameter collectionView: The collection view.
    /// - Parameter indexPath: The selected cell's index path.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onCellClicked(index: indexPath.item)
    }
}
