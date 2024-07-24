//
//  CacheLayer.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import CoreData

/// A singleton class responsible for managing the Core Data stack and providing access to the `NSManagedObjectContext`
/// for background operations.
public class CacheLayer: CacheLayerProtocol {
    
    /// The shared singleton instance of `CacheLayer`.
    ///
    /// This property provides a global point of access to the `CacheLayer` instance.
    public static let instance = CacheLayer()
    
    // MARK: - Private Properties
    
    /// The Core Data persistent container for managing the Core Data stack.
    ///
    /// This property initializes the persistent container with the model name "Model" and loads the persistent stores.
    /// If an error occurs during loading, the application will terminate with a fatal error.
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = CoreDataContainer(name: "Model", bundle: .module)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading persistent stores: \(SephoraError.dataBaseError(originalError: error))")
            }
        }
        return container
    }()
    
    // MARK: - Public Properties
    
    /// A background context for performing Core Data operations on a background thread.
    ///
    /// This context is used for operations that do not need to be performed on the main thread. It is initialized with a
    /// merge policy that favors changes from the context over changes from other contexts.
    public lazy var backgroundContext: NSManagedObjectContext = {
        var context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()
}
