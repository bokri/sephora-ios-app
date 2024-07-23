//
//  SephoraRepositoryProtocol.swift
//  
//
//  Created by Aymen Bokri on 23/07/2024.
//

import CoreData

protocol SephoraRepositoryProtocol {
    func getProducts() throws -> [ProductItemModel]
    func addProductItems(products: [ProductItem]) throws
}
