//
//  SephoraRepositoryProtocol.swift
//  
//
//  Created by Aymen Bokri on 23/07/2024.
//

import CoreData
import Entities

/// Protocol defining the operations for interacting with the product repository.
public protocol SephoraRepositoryProtocol {
    
    /// Fetches all product items from the repository.
    func getProducts() throws -> [ProductItemModel]
    
    /// Adds or updates product items in the repository.
    func addProductItems(products: [ProductItem]) throws
}
