//
//  ImagesUrlTests.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import XCTest
@testable import Entities

class ImagesUrlTests: XCTestCase {

    func testImagesUrlDecoding() {
        let json = """
        {
            "small": "https://example.com/small.jpg",
            "large": "https://example.com/large.jpg"
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let imagesUrl = try decoder.decode(ImagesUrl.self, from: json)
            
            XCTAssertEqual(imagesUrl.small, "https://example.com/small.jpg")
            XCTAssertEqual(imagesUrl.large, "https://example.com/large.jpg")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    func testImagesUrlDecodingWithoutLarge() {
        let json = """
        {
            "small": "https://example.com/small.jpg"
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let imagesUrl = try decoder.decode(ImagesUrl.self, from: json)
            
            XCTAssertEqual(imagesUrl.small, "https://example.com/small.jpg")
            XCTAssertNil(imagesUrl.large)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    func testImagesUrlDecodingInvalidData() {
        let json = """
        {
            "thumbnail": "https://example.com/small.jpg",
            "fullsize": "https://example.com/large.jpg"
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            _ = try decoder.decode(ImagesUrl.self, from: json)
            XCTFail("Decoding should have failed due to incorrect field names")
        } catch {
            // Expected error
        }
    }
}
