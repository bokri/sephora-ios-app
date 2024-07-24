//
//  ProductItem.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

public struct ProductItem: Decodable {
    public let productId: Int64
    public let productName: String
    public let description: String
    public let price: Float
    public let imagesUrl: ImagesUrl?
    public let cBrand: Brand
    public let isSpecialBrand: Bool
    
    public init(
        productId: Int64,
        productName: String,
        description: String,
        price: Float,
        imagesUrl: ImagesUrl?,
        cBrand: Brand,
        isSpecialBrand: Bool
    ) {
        self.productId = productId
        self.productName = productName
        self.description = description
        self.price = price
        self.imagesUrl = imagesUrl
        self.cBrand = cBrand
        self.isSpecialBrand = isSpecialBrand
    }
}
