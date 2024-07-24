//
//  MockCacheLayer.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
@testable import SephoraBusiness

class MockCacheLayer: CacheLayerProtocol {
    
    public static let instance = MockCacheLayer()
    
    private lazy var persistentContainer: CoreDataContainer = {
        let container =  CoreDataContainer(name: "Model", bundle: Bundle.module, inMemory: true)
        return container
    }()
    
    public lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()
}
