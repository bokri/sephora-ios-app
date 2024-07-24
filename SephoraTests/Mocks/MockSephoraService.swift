//
//  MockSephoraService.swift
//  SephoraTests
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import Entities
@testable import SephoraBusiness

class MockSephoraService: SephoraServiceProtocol {
    var mockProducts: [ProductItem] = []
    var mockError: Error?
    
    func getProducts() async throws -> [ProductItem] {
        if let error = mockError {
            throw error
        }
        return mockProducts
    }
}
