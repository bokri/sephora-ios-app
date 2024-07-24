//
//  ProductDetailsViewModel.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import Entities

class ProductDetailsViewModel {
    weak var coordinator: ProductDetailViewControllerDelegate?
    var productItem: ProductItem
    
    init(coordinator: ProductDetailViewControllerDelegate?, productItem: ProductItem) {
        self.coordinator = coordinator
        self.productItem = productItem
    }
    
    func onBackDetected() {
        coordinator?.backToListView()
    }
    
}
