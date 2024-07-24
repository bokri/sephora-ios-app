//
//  ProductCollectionViewDataSource.swift
//  Sephora
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit
import Entities
import Components

/// Manages collection view data for displaying products.
class ProductCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    /// List of products to display.
    private var products: [ProductItem] = []
    
    /// Reference to the collection view.
    private weak var collectionView: UICollectionView?
    
    // MARK: - Constructor
    
    /// Sets up the data source with a collection view.
    /// - Parameter collectionView: The collection view to manage.
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView?.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    /// Returns the number of items in the section.
    /// - Parameter section: The section index.
    /// - Returns: Number of items.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    /// Provides the cell for a specific item.
    /// - Parameter indexPath: The cell’s index path.
    /// - Returns: Configured cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductCollectionViewCell.self, for: indexPath)
        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
    
    // MARK: - Method
    
    /// Updates products and reloads the collection view.
    /// - Parameter products: New list of products.
    func update(products: [ProductItem]) {
        self.products = products
        collectionView?.reloadData()
    }
}
