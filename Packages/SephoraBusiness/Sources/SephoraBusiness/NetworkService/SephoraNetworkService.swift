//
//  SephoraNetworkService.swift
//
//
//  Created by Aymen Bokri on 20/06/2024.
//

import Foundation

public actor SephoraNetworkService: SephoraNetworkServiceProtocol {
    
    private var networkService: NetworkServiceProtocol
    
    public init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    public func getProducts() async throws -> [ProductItem] {
        do {
            let endpoint = SephoraApiEndpoint.getProducts
            
            let results = try await networkService.fetchData(endpoint, type: [ProductItem].self)
            
            return results
        } catch {
            throw SephoraError.productsError(originalError: error)
        }
    }
}
