//
//  SephoraServiceProtocol.swift
//
//
//  Created by Aymen Bokri on 20/06/2024.
//

import Foundation

protocol SephoraServiceProtocol: Actor {
    func getProducts() async throws -> [ProductItem]
}
