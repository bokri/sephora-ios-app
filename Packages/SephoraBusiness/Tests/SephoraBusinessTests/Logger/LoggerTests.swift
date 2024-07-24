//
//  LoggerTests.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
@testable import SephoraBusiness

final class LoggerTests: XCTestCase {

    private var mockDestination: MockLogDestination!

    override func setUp() {
        super.setUp()
        mockDestination = MockLogDestination()
        Logger.addDestination(mockDestination)
    }

    override func tearDown() {
        Logger.destinations = [ConsoleDestination()] // Reset to default destinations
        super.tearDown()
    }

    func testDebugLog() {
        // Given
        let message = "Debug message"
        
        // When
        Logger.debug(message)
        
        // Then
        XCTAssertEqual(mockDestination.debugMessages.count, 1)
        XCTAssertTrue(mockDestination.debugMessages.first?.contains(message) ?? false)
    }

    func testWarningLog() {
        // Given
        let message = "Warning message"
        
        // When
        Logger.warning(message)
        
        // Then
        XCTAssertEqual(mockDestination.warningMessages.count, 1)
        XCTAssertTrue(mockDestination.warningMessages.first?.contains(message) ?? false)
    }

    func testErrorLogWithError() {
        // Given
        let error = NSError(domain: "test", code: 1, userInfo: nil)
        
        // When
        Logger.error(error)
        
        // Then
        XCTAssertEqual(mockDestination.errorMessages.count, 1)
        XCTAssertEqual(mockDestination.errorMessages.first?.error.localizedDescription, error.localizedDescription)
    }

    func testErrorLogWithMessage() {
        // Given
        let message = "Error message"
        
        // When
        Logger.error(message)
        
        // Then
        XCTAssertEqual(mockDestination.errorMessageStrings.count, 1)
        XCTAssertTrue(mockDestination.errorMessageStrings.first?.message.contains(message) ?? false)
    }
}
