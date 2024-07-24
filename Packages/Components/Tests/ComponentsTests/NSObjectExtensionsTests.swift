import XCTest
@testable import Components

class NSObjectExtensionsTests: XCTestCase {

    func testClassName() {
        // Given
        let expectedClassName = "NSObjectExtensionsTests"
        
        // When
        let actualClassName = NSObjectExtensionsTests.className
        
        // Then
        XCTAssertEqual(expectedClassName, actualClassName, "Expected className to be '\(expectedClassName)' but got '\(actualClassName)'")
    }
}
