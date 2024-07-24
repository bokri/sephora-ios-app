//
//  File.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
import CoreData
@testable import SephoraBusiness

final class CacheLayerTests: XCTestCase {
    var cacheLayer: CacheLayer!

    override func setUp() {
        super.setUp()
        // Create CacheLayer with in-memory store for testing
        cacheLayer = CacheLayer.instance
    }

    override func tearDown() {
        cacheLayer = nil
        super.tearDown()
    }

    func testPersistentContainerInitialization() {
        // Check if persistentContainer is initialized properly
        XCTAssertNotNil(cacheLayer.persistentContainer, "Persistent container should be initialized")
    }

    func testBackgroundContextInitialization() {
        // Check if backgroundContext is initialized properly
        XCTAssertNotNil(cacheLayer.backgroundContext, "Background context should be initialized")
        XCTAssertEqual(cacheLayer.backgroundContext.mergePolicy as! NSMergePolicy, NSMergePolicy.mergeByPropertyObjectTrump, "Merge policy should be mergeByPropertyObjectTrump")
    }

    func testInMemoryPersistentContainer() {
        // Create an instance of CacheLayer with in-memory store
        let cacheLayer = CacheLayer()
        cacheLayer.persistentContainer = CoreDataContainer(name: "Model", bundle: Bundle(for: type(of: self)), inMemory: true)

        // Test if the container is using in-memory store
        let storeDescriptions = cacheLayer.persistentContainer.persistentStoreDescriptions
        XCTAssertEqual(storeDescriptions.first?.type, NSInMemoryStoreType, "Persistent store type should be in-memory")
    }
}
