//
//  CoreDataContainerTests.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
import CoreData
@testable import SephoraBusiness

class CoreDataContainerTests: XCTestCase {
    
    var mockBundle: Bundle!
    
    override func setUp() {
        super.setUp()
        // Creating a mock bundle with a test Core Data model
        mockBundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        mockBundle = nil
        super.tearDown()
    }
    
    func testCoreDataContainerInitialization() {
        let containerName = "TestContainer"
        
        let coreDataContainer = CoreDataContainer(name: containerName, bundle: mockBundle)
        
        XCTAssertNotNil(coreDataContainer)
        XCTAssertEqual(coreDataContainer.name, containerName)
        XCTAssertNotNil(coreDataContainer.persistentStoreCoordinator)
    }
    
    func testCoreDataContainerInitializationInMemory() {
        let containerName = "TestContainer"
        
        let coreDataContainer = CoreDataContainer(name: containerName, bundle: mockBundle, inMemory: true)
        
        XCTAssertNotNil(coreDataContainer)
        XCTAssertEqual(coreDataContainer.name, containerName)
        XCTAssertNotNil(coreDataContainer.persistentStoreCoordinator)
        
        guard let storeDescription = coreDataContainer.persistentStoreDescriptions.first else {
            XCTFail("No persistent store description found")
            return
        }
        
        XCTAssertEqual(storeDescription.type, NSInMemoryStoreType)
    }
}
