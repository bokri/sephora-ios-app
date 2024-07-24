//
//  CoreDataContainer.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData

public class CoreDataContainer: NSPersistentContainer {
    
    // Initialize with an optional in-memory store
    public init(name: String, bundle: Bundle, inMemory: Bool = false) {
        guard let mom = NSManagedObjectModel.mergedModel(from: [bundle]) else {
            fatalError("Failed to create mom")
        }
        super.init(name: name, managedObjectModel: mom)
        
        if inMemory {
            // Configure the store description for in-memory storage
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentStoreDescriptions = [description]
        }
    }
}
