//
//  ProductDetailsViewModelTests.swift
//  SephoraTests
//
//  Created by Aymen Bokri on 24/07/2024.
//

import XCTest
import Entities
@testable import Sephora
import RxTest

class ProductDetailsViewModelTests: XCTestCase {

    var viewModel: ProductDetailsViewModel!
    var mockCoordinator: MockProductDetailViewControllerDelegate!
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockProductDetailViewControllerDelegate()
        let dummyProductItem = ProductItem(
            productId: 1,
            productName: "Sample Product",
            description: "Sample Description",
            price: 10.0,
            imagesUrl: nil,
            cBrand: Brand(id: "1", name: "Sample Brand"), // Assuming Brand conforms to required initializer
            isSpecialBrand: false
        )
        viewModel = ProductDetailsViewModel(coordinator: mockCoordinator, productItem: dummyProductItem)
    }

    override func tearDown() {
        viewModel = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func testOnBackDetectedCallsCoordinator() {
        // When
        viewModel.onBackDetected()
        
        // Then
        XCTAssertTrue(mockCoordinator.didCallBackToListView, "Expected backToListView to be called on coordinator")
    }
}
