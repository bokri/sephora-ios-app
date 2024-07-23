//
//  CacheLayer.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import CoreData


final class CacheLayer {
    
    static let instance = CacheLayer()
    
    // MARK: - Private
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error of type \(SephoraError.dataBaseError(originalError: error))")
            }
        })
        return container
    }()
    
    // MARK: - Public
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
}
