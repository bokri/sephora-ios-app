//
//  ProductItem+Extensions.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import Entities
import CoreData

extension ProductItem {
    /// Converts `ProductItem` to `ProductItemModel` for Core Data storage.
    public func toProductItemModel(context: CoreData.NSManagedObjectContext) -> ProductItemModel {
        let model = ProductItemModel(context: context)
        model.productId = productId
        model.productName = productName
        model.productDescription = description
        model.price = price
        model.imagesUrl = imagesUrl?.toImagesUrlModel(context: context)
        model.cBrand = cBrand.toBrandModel(context: context)
        model.isSpecialBrand = isSpecialBrand
        return model
    }
}
