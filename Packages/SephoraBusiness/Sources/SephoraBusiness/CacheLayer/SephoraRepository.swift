//
//  SephoraRepository.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

final class SephoraRepository: SephoraRepositoryProtocol {
    
    // MARK: - Properties

      private let cacheLayer: CacheLayer

      // MARK: - Init

      init(cacheLayer: CacheLayer = CacheLayer.instance) {
        self.cacheLayer = cacheLayer
      }
    
    
    func getProducts() throws -> [ProductItemModel] {
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
    
    func addProductItems(products: [ProductItem]) throws {
        
        let products = products.map { item in
            let model = ProductItemModel(context: cacheLayer.backgroundContext)
            model.productId = item.productId
            model.productName = item.productName
            model.productDescription = item.description
            model.price = item.price
            
            model.imagesUrl = ImagesUrlModel(context: cacheLayer.backgroundContext)
            model.imagesUrl?.id = UUID()
            model.imagesUrl?.large = item.imagesUrl?.large
            model.imagesUrl?.small = item.imagesUrl?.small
            
            model.cBrand = BrandModel(context: cacheLayer.backgroundContext)
            model.cBrand?.id = item.cBrand.id
            model.cBrand?.name = item.cBrand.name
            
            model.isSpecialBrand = item.isSpecialBrand
        }
        
        do {
            try cacheLayer.backgroundContext.save()
        } catch {
            throw SephoraError.dataBaseError(originalError: error)
        }
    }
}
