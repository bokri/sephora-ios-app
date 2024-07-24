//
//  NetworkServiceTests.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
@testable import SephoraBusiness
import OHHTTPStubs
import OHHTTPStubsSwift
import Entities

class NetworkServiceTests: XCTestCase {
    
    let networkService = NetworkService();
    
    override func setUp() {
        HTTPStubs.removeAllStubs()
    }
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
        
        super.tearDown()
    }
    
    // Test fetching a list of items from the Sephora API
    func testFetchMoviesList() async {
        // Stub an HTTP request to simulate the Sephora API response
        _ = stub(condition: isHost("sephoraios.github.io")) { (_) -> HTTPStubsResponse in
            
            if let bundlePath = Bundle.module.resourcePath {
                let stubPath = URL(fileURLWithPath: bundlePath).appendingPathComponent("items.json").path
                return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
            }
            
            return HTTPStubsResponse()
        }
        
        // Act: Fetch items using the NetworkManager
        do {
            let products: [ProductItem] = try await networkService.fetchData(SephoraApiEndpoint.getProducts, type: [ProductItem].self)
            
            
            // Assert: Verify the results
            XCTAssertEqual(products.count, 6, "Expected 6 items in the list")
            
            // Assertions for individual product properties
            XCTAssertEqual(products[0].productId, 1461267310, "Incorrect product ID")
            XCTAssertEqual(products[0].productName, "Size Up - Mascara Volume Extra Large Immédiat", "Incorrect product name")
            XCTAssertEqual(products[0].price, 140.0, "Incorrect product price")

            // You can add more assertions for other movies if needed
        } catch {
            XCTFail("Failed to fetch movies: \(error)")
        }
    }
}
