//
//  ProductItemModel+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
import Entities

extension ProductItemModel {
    public func toEntity() -> ProductItem? {
        guard let productName = productName,
              let productDescription = productDescription,
              let cBrand = cBrand?.toEntity()
        else { return nil }
        
        return ProductItem(
            productId: productId,
            productName: productName,
            description: productDescription,
            price: price,
            imagesUrl: imagesUrl?.toEntity(),
            cBrand: cBrand,
            isSpecialBrand: isSpecialBrand
        )
    }
}
