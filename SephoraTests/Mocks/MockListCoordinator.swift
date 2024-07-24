//
//  MockCoordinator.swift
//  SephoraTests
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import Entities
@testable import Sephora

class MockListCoordinator: ListViewControllerDelegate {
    var didGoToDetailViewCalled = false
    var productItem: ProductItem?
    
    func goToDetailView(productItem: ProductItem) {
        didGoToDetailViewCalled = true
        self.productItem = productItem
    }
}
