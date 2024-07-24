//
//  MockNetworkService.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
@testable import SephoraBusiness

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<Any, Error>?
    
    func fetchData<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T {
        switch result {
        case .success(let data as T):
            return data
        case .failure(let error):
            throw error
        default:
            fatalError("Result not set or type mismatch")
        }
    }
}
