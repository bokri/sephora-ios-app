//
//  SephoraRepositoryProtocol.swift
//  
//
//  Created by Aymen Bokri on 23/07/2024.
//

import CoreData

public protocol SephoraRepositoryProtocol {
    func getProducts() throws -> [ProductItemModel]
    func addProductItems(products: [ProductItem]) throws
}
