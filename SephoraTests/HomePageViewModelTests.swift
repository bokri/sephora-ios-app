//
//  SephoraTests.swift
//  SephoraTests
//
//  Created by Aymen Bokri on 24/07/2024.
//

import XCTest
import RxSwift
import RxRelay
import Entities
@testable import Sephora
import RxTest

class HomePageViewModelTests: XCTestCase {

    var viewModel: HomePageViewModel!
    var mockService: MockSephoraService!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var stateObserver: TestableObserver<HomePageState>!
    var productsObserver: TestableObserver<[ProductItem]>!
    var mockCoordinator: MockListCoordinator!

    override func setUp() {
        super.setUp()
        mockService = MockSephoraService()
        mockCoordinator = MockListCoordinator()
        viewModel = HomePageViewModel(sephoraService: mockService, coordinator: mockCoordinator)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        
        // Use RxTest's TestableObserver
        stateObserver = scheduler.createObserver(HomePageState.self)
        productsObserver = scheduler.createObserver([ProductItem].self)
        
        // Observe state changes
        viewModel.state
            .subscribe(stateObserver)
            .disposed(by: disposeBag)
        
        // Observe products changes
        viewModel.products
            .subscribe(productsObserver)
            .disposed(by: disposeBag)
    }

    func testInitialState() {
        // Assert the initial state and empty products
        XCTAssertEqual(viewModel.products.value, [])
    }

    func testGetProductsSuccess() async {
        // Given
        let expectedProducts = [ProductItem(productId: 1, productName: "Product 1", description: "Description", price: 10.0, imagesUrl: nil, cBrand: Brand(id: "brandId", name: "Brand"), isSpecialBrand: false)]
        mockService.mockProducts = expectedProducts
        
        // When
        await viewModel.getProducts()
        
        // Wait for a short period to ensure async operations are completed
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Then
        XCTAssertEqual(viewModel.products.value, expectedProducts)
        XCTAssertEqual(stateObserver.events.map { $0.value.element }, [.loading, .success])
    }

    func testGetProductsFailure() async {
        // Given
        mockService.mockError = NSError(domain: "Test", code: 1, userInfo: nil)
        
        // When
        await viewModel.getProducts()
        
        // Wait for a short period to ensure async operations are completed
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Then
        XCTAssertEqual(viewModel.products.value, [])
        XCTAssertEqual(stateObserver.events.map { $0.value.element }, [.loading, .error])
    }

    func testOnCellClicked() {
        // Given
        let product = ProductItem(productId: 1, productName: "Product 1", description: "Description", price: 10.0, imagesUrl: nil, cBrand: Brand(id: "brandId", name: "Brand"), isSpecialBrand: false)
        viewModel.products.accept([product])
        
        // When
        viewModel.onCellClicked(index: 0)
        
        // Then
        XCTAssertTrue(mockCoordinator.didGoToDetailViewCalled)
        XCTAssertEqual(mockCoordinator.productItem?.productId, product.productId)
    }
}
