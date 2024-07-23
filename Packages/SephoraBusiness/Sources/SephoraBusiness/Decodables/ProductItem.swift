//
//  ProductItem.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

public struct ProductItem: Decodable {
    let productId: Int64
    let productName: String
    let description: String
    let price: Float
    let imagesUrl: ImagesUrl?
    let cBrand: Brand
    let isSpecialBrand: Bool
}
