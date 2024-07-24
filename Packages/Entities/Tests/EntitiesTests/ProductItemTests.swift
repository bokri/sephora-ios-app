//
//  ProductItemTests.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import XCTest
@testable import Entities

class ProductItemTests: XCTestCase {

    func testProductItemDecoding() {
        let json = """
        {
            "product_id": 1234567890,
            "product_name": "Test Product",
            "description": "This is a test product",
            "price": 99.99,
            "images_url": {
                "small": "https://example.com/small.jpg",
                "large": "https://example.com/large.jpg"
            },
            "c_brand": {
                "id": "BRAND1",
                "name": "Brand One"
            },
            "is_special_brand": true
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let productItem = try decoder.decode(ProductItem.self, from: json)
            
            XCTAssertEqual(productItem.productId, 1234567890)
            XCTAssertEqual(productItem.productName, "Test Product")
            XCTAssertEqual(productItem.description, "This is a test product")
            XCTAssertEqual(productItem.price, 99.99)
            XCTAssertEqual(productItem.imagesUrl?.small, "https://example.com/small.jpg")
            XCTAssertEqual(productItem.imagesUrl?.large, "https://example.com/large.jpg")
            XCTAssertEqual(productItem.cBrand.id, "BRAND1")
            XCTAssertEqual(productItem.cBrand.name, "Brand One")
            XCTAssertEqual(productItem.isSpecialBrand, true)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func testProductItemDecodingWithoutImageUrl() {
        let json = """
        {
            "product_id": 1234567890,
            "product_name": "Test Product",
            "description": "This is a test product",
            "price": 99.99,
            "c_brand": {
                "id": "BRAND1",
                "name": "Brand One"
            },
            "is_special_brand": true
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let productItem = try decoder.decode(ProductItem.self, from: json)
            
            XCTAssertEqual(productItem.productId, 1234567890)
            XCTAssertEqual(productItem.productName, "Test Product")
            XCTAssertEqual(productItem.description, "This is a test product")
            XCTAssertEqual(productItem.price, 99.99)
            XCTAssertNil(productItem.imagesUrl)
            XCTAssertEqual(productItem.cBrand.id, "BRAND1")
            XCTAssertEqual(productItem.cBrand.name, "Brand One")
            XCTAssertEqual(productItem.isSpecialBrand, true)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    func testProductItemDecodingInvalidData() {
        let json = """
        {
            "id": 1234567890,
            "name": "Test Product",
            "details": "This is a test product",
            "cost": 99.99,
            "brand": {
                "identifier": "BRAND1",
                "brandName": "Brand One"
            },
            "special": true
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            _ = try decoder.decode(ProductItem.self, from: json)
            XCTFail("Decoding should have failed due to incorrect field names")
        } catch {
            // Expected error
        }
    }
}
