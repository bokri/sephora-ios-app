//
//  File.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
import Entities
@testable import SephoraBusiness

public final class MockSephoraRepository: SephoraRepositoryProtocol {

    private var products: [ProductItemModel] = []

    public init() {}

    public func getProducts() throws -> [ProductItemModel] {
        return products
    }

    public func addProductItems(products: [ProductItem]) throws {
        self.products = products.map { item in
            // Create a mock ProductItemModel from ProductItem
            let product = ProductItemModel()
            product.productId = item.productId
            product.productName = item.productName
            product.productDescription = item.description
            product.price = item.price
            
            product.imagesUrl = ImagesUrlModel()
            product.imagesUrl?.id = UUID()
            product.imagesUrl?.small = item.imagesUrl?.small
            product.imagesUrl?.large = item.imagesUrl?.large
            
            product.cBrand = BrandModel()
            product.cBrand?.id = item.cBrand.id
            product.cBrand?.name = item.cBrand.name
            
            product.isSpecialBrand = item.isSpecialBrand
            return product
        }
    }
}
