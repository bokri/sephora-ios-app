//
//  CacheLayer.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import CoreData


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
        var context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()
}
