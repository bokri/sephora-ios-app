//
//  BrandTests.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import XCTest
@testable import Entities

class BrandTests: XCTestCase {

    func testBrandDecoding() {
        let json = """
        {
            "id": "SEPHO",
            "name": "SEPHORA COLLECTION"
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let brand = try decoder.decode(Brand.self, from: json)
            
            XCTAssertEqual(brand.id, "SEPHO")
            XCTAssertEqual(brand.name, "SEPHORA COLLECTION")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    func testBrandDecodingMissingFields() {
        let json = """
        {
            "id": "SEPHO"
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            _ = try decoder.decode(Brand.self, from: json)
            XCTFail("Decoding should have failed due to missing fields")
        } catch {
            // Expected error
        }
    }
    
    func testBrandDecodingInvalidData() {
        let json = """
        {
            "identifier": "SEPHO",
            "brandName": "SEPHORA COLLECTION"
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            _ = try decoder.decode(Brand.self, from: json)
            XCTFail("Decoding should have failed due to incorrect field names")
        } catch {
            // Expected error
        }
    }
}
