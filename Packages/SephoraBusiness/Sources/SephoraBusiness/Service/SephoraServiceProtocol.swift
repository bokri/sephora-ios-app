//
//  SephoraServiceProtocol.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import Entities

public protocol SephoraServiceProtocol {
    /// Asynchronously fetches a list of `ProductItem` objects.
    func getProducts() async throws -> [ProductItem]
}
