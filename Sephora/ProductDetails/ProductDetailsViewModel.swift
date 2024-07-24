//
//  ProductDetailsViewModel.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import Entities

class ProductDetailsViewModel {
    
    // MARK: - Properties
    
    private weak var coordinator: ProductDetailViewControllerDelegate? // Coordinator for navigation actions
    private(set) var productItem: ProductItem // Product item data
    
    // MARK: - Constructor
    
    init(coordinator: ProductDetailViewControllerDelegate?, productItem: ProductItem) {
        self.coordinator = coordinator
        self.productItem = productItem
    }
    
    // MARK: - Methods
    
    func onBackDetected() {
        coordinator?.backToListView() // Notify coordinator to navigate back to list view
    }
}
