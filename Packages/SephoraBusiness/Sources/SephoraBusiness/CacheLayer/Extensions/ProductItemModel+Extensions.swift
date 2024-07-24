//
//  ProductItemModel+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
import Entities

// MARK: - ProductItemModel Extension

extension ProductItemModel {
    
    /// Converts a `ProductItemModel` instance to a `ProductItem` entity.
    public func toEntity() -> ProductItem? {
        // Ensure that the required properties are non-nil.
        guard let productName = productName,
              let productDescription = productDescription,
              let cBrand = cBrand?.toEntity() // Convert the nested `cBrand` model to an entity.
        else {
            // If any required property is nil, return nil.
            return nil
        }
        
        // Return a `ProductItem` entity initialized with the properties of the model.
        return ProductItem(
            productId: productId,
            productName: productName,
            description: productDescription,
            price: price,
            imagesUrl: imagesUrl?.toEntity(), // Convert `imagesUrl` model to an entity if present.
            cBrand: cBrand,
            isSpecialBrand: isSpecialBrand
        )
    }
}
