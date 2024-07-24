//
//  SephoraRepository.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import Entities
import CoreData

/// Manages `ProductItem` objects using Core Data.
public class SephoraRepository: SephoraRepositoryProtocol {
    
    // MARK: - Properties
    
    /// Provides Core Data context for operations.
    private let cacheLayer: CacheLayerProtocol
    
    // MARK: - Init
    
    /// Initializes with a given cache layer.
    /// - Parameter cacheLayer: Core Data context provider.
    public init(cacheLayer: CacheLayerProtocol = CacheLayer.instance) {
        self.cacheLayer = cacheLayer
    }
    
    // MARK: - Public Methods
    
    /// Fetches all `ProductItemModel` objects from Core Data.
    /// - Throws: `SephoraError.dataBaseError` on failure.
    /// - Returns: List of `ProductItemModel` objects.
    public func getProducts() throws -> [ProductItemModel] {
        do {
            // Create a fetch request for `ProductItemModel` entities
            let fetchRequest = ProductItemModel.fetchRequest()
            
            // Define a sort descriptor to sort by `isSpecialBrand` in descending order
            let sortDescriptor = NSSortDescriptor(key: "isSpecialBrand", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Execute the fetch request
            let products = try cacheLayer.backgroundContext.fetch(fetchRequest)
            return products
        } catch {
            // Log the error and rethrow it as a `SephoraError.dataBaseError`
            Logger.error("Error on getting products from database: \(error.localizedDescription)")
            throw SephoraError.dataBaseError(originalError: error)
        }
    }

    /// Adds or updates `ProductItem` objects and removes old ones.
    /// - Parameter products: List of `ProductItem` to add.
    /// - Throws: `SephoraError.dataBaseError` on failure.
    public func addProductItems(products: [ProductItem]) throws {
        // Fetch existing products from the database
        let oldProducts = try getProducts()
        
        // Convert new products to Core Data models
        let newProducts = products.map { item -> NSManagedObject in
            return item.toProductItemModel(context: cacheLayer.backgroundContext)
        }
        
        // Identify products that should be deleted from Core Data
        let deletedProducts = oldProducts.filter { oldModel in
            !newProducts.contains(oldModel) // Compare existing models with new ones
        }
        
        do {
            // Delete products no longer present in the new list
            for product in deletedProducts {
                cacheLayer.backgroundContext.delete(product)
            }
            // Save the changes to Core Data
            try cacheLayer.backgroundContext.save()
        } catch {
            // Log the error and rethrow it
            Logger.error("Error on saving products to database: \(error.localizedDescription)")
            throw SephoraError.dataBaseError(originalError: error)
        }
    }
}
