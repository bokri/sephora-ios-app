//
//  CacheLayer.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import CoreData

public final class CoreDataContainer: NSPersistentContainer {
  public init(name: String, bundle: Bundle,
    inMemory: Bool = false) {
    guard let mom = NSManagedObjectModel.mergedModel(from: [bundle]) else {
      fatalError("Failed to create mom")
    }
    super.init(name: name, managedObjectModel: mom)
  }
}


public final class CacheLayer {
    
    public static let instance = CacheLayer()
    
    // MARK: - Private
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = CoreDataContainer(name: "Model", bundle: .module)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error of type \(SephoraError.dataBaseError(originalError: error))")
            }
        })
        return container
    }()
    
    // MARK: - Public
    
    public lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
}
