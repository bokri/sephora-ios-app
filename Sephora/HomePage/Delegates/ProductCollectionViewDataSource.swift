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

class ProductCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private var products: [ProductItem] = []
    private weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView?.dataSource = self
    }
    
    func update(products: [ProductItem]) {
        self.products = products
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductCollectionViewCell.self, for: indexPath)
        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}
