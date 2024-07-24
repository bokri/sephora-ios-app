//
//  ProductCollectionViewDelegate.swift
//  Sephora
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit
import SephoraBusiness

class ProductCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    weak var delegate: HomePageDelegate?
    
    func setupDelegate(delegate: HomePageDelegate?) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onCellClicked(index: indexPath.item)
    }
}
