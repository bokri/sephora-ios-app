//
//  MockProductDetailViewControllerDelegate.swift
//  SephoraTests
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import Entities
@testable import Sephora

class MockProductDetailViewControllerDelegate: ProductDetailViewControllerDelegate {
    var didCallBackToListView = false
    
    func backToListView() {
        didCallBackToListView = true
    }
}
