//
//  SephoraNetworkServiceTests.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
import Entities
@testable import SephoraBusiness

final class SephoraNetworkServiceTests: XCTestCase {
    private var mockNetworkService: MockNetworkService!
    private var sephoraNetworkService: SephoraNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sephoraNetworkService = SephoraNetworkService(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        sephoraNetworkService = nil
        super.tearDown()
    }
    
    func testGetProductsSuccess() async throws {
        // Given
        let brand = Brand(id: "brand1", name: "Brand 1")
        let imageUrl = ImagesUrl(small: "small_url", large: "large_url")
        let expectedProducts = [
            ProductItem(
                productId: 1,
                productName: "Product 1",
                description: "Description 1",
                price: 10.0,
                imagesUrl: imageUrl,
                cBrand: brand,
                isSpecialBrand: true
            ),
            ProductItem(
                productId: 2,
                productName: "Product 2",
                description: "Description 2",
                price: 20.0,
                imagesUrl: imageUrl,
                cBrand: brand,
                isSpecialBrand: false
            )
        ]
        mockNetworkService.result = .success(expectedProducts)
        
        // When
        let products = try await sephoraNetworkService.getProducts()
        
        // Then
        XCTAssertEqual(products.count, expectedProducts.count)
        XCTAssertEqual(products.first?.productId, expectedProducts.first?.productId)
        XCTAssertEqual(products.first?.productName, expectedProducts.first?.productName)
    }
    
    func testGetProductsFailure() async {
        // Given
        let expectedError = NetworkError.requestFailed(originalError: NSError(domain: "", code: -1, userInfo: nil))
        mockNetworkService.result = .failure(expectedError)
        
        // When
        do {
            _ = try await sephoraNetworkService.getProducts()
            XCTFail("Expected to throw, but it did not")
        } catch let error as SephoraError {
            // Then
            switch error {
            case .productsError(let originalError):
                XCTAssertEqual(originalError.localizedDescription, expectedError.localizedDescription)
            default:
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
