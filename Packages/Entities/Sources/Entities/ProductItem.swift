//
//  ProductItem.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

// Represents a product with various details
public struct ProductItem: Decodable {
    
    // MARK: - Properties
    
    public let productId: Int64 // Unique identifier for the product
    public let productName: String // Name of the product
    public let description: String // Description of the product
    public let price: Float // Price of the product
    public let imagesUrl: ImagesUrl? // Optional URLs for product images
    public let cBrand: Brand // Brand of the product
    public let isSpecialBrand: Bool // Flag indicating if the brand is special
    
    // MARK: - Constructors
    
    // Initializes a ProductItem with provided values
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

// MARK: - Equatable

extension ProductItem: Equatable {
    public static func == (lhs: ProductItem, rhs: ProductItem) -> Bool {
        lhs.productId == rhs.productId // Equality based on productId
    }
}
