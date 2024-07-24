//
//  MockSephoraNetworkService.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
import Entities
@testable import SephoraBusiness

class MockSephoraNetworkService: SephoraNetworkServiceProtocol {
    var result: Result<[ProductItem], Error>?

    func getProducts() async throws -> [ProductItem] {
        if let result = result {
            switch result {
            case .success(let products):
                return products
            case .failure(let error):
                throw error
            }
        }
        return []
    }
}
