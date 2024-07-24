//
//  SephoraNetworkServiceProtocol.swift
//
//
//  Created by Aymen Bokri on 20/06/2024.
//

import Foundation
import Entities

public protocol SephoraNetworkServiceProtocol: Actor {
    func getProducts() async throws -> [ProductItem]
}
