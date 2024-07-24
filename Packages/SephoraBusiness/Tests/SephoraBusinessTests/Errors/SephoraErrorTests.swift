//
//  SephoraErrorTests.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
@testable import SephoraBusiness // Replace with your module name

final class SephoraErrorTests: XCTestCase {
    
    func testProductsError() {
        // Given
        let originalError = NSError(domain: "test", code: 1, userInfo: nil)
        
        // When
        let error = SephoraError.productsError(originalError: originalError)
        
        // Then
        if case let SephoraError.productsError(capturedError) = error {
            XCTAssertEqual(capturedError as NSError, originalError, "The captured error should be the same as the original error")
        } else {
            XCTFail("Expected productsError but got a different error type")
        }
    }
    
    func testDataBaseError() {
        // Given
        let originalError = NSError(domain: "test", code: 2, userInfo: nil)
        
        // When
        let error = SephoraError.dataBaseError(originalError: originalError)
        
        // Then
        if case let SephoraError.dataBaseError(capturedError) = error {
            XCTAssertEqual(capturedError as NSError, originalError, "The captured error should be the same as the original error")
        } else {
            XCTFail("Expected dataBaseError but got a different error type")
        }
    }
}
