//
//  CacheLayerProtocol.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData

/// A protocol that defines the requirements for a cache layer responsible for managing Core Data operations.
public protocol CacheLayerProtocol {
    var backgroundContext: NSManagedObjectContext { get }
}
