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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logger.debug("Click on \(indexPath.item)")
    }
}
