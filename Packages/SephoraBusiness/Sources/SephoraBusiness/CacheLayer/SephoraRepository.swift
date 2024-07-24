//
//  SephoraRepository.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import Entities
import CoreData

public final class SephoraRepository: SephoraRepositoryProtocol {
    
    // MARK: - Properties

      private let cacheLayer: CacheLayer

      // MARK: - Init

    public init(cacheLayer: CacheLayer = CacheLayer.instance) {
        self.cacheLayer = cacheLayer
      }
    
    
    public func getProducts() throws -> [ProductItemModel] {
        do {
            let fetchRequest = ProductItemModel.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "isSpecialBrand", ascending: true)
            fetchRequest.sortDescriptors = []
            let products = try cacheLayer.backgroundContext.fetch(fetchRequest)
            return products
        } catch {
            throw SephoraError.dataBaseError(originalError: error)
        }
    }
    
    public func addProductItems(products: [ProductItem]) throws {
        
        let oldProducts = try getProducts()
        
        let newProducts = products.map { item -> NSManagedObject in
            let model = item.toProductItemModel(context: cacheLayer.backgroundContext)
            return model
        }
        
        let deletedProducts = oldProducts.filter { oldModel in
            newProducts.contains(oldModel) == false
        }
        
        do {
            for product in deletedProducts {
                try cacheLayer.backgroundContext.delete(product)
            }
            try cacheLayer.backgroundContext.save()
        } catch {
            throw SephoraError.dataBaseError(originalError: error)
        }
    }
}
