//
//  CoreDataContainer.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData

public final class CoreDataContainer: NSPersistentContainer {
    
    public init(name: String, bundle: Bundle) {
        guard let mom = NSManagedObjectModel.mergedModel(from: [bundle]) else {
            fatalError("Failed to create mom")
        }
        super.init(name: name, managedObjectModel: mom)
    }
}
