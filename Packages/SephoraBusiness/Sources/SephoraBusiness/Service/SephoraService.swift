//
//  SephoraService.swift
//
//
//  Created by Aymen Bokri on 20/06/2024.
//

import Foundation

actor SephoraService: SephoraServiceProtocol {
    
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getProducts() async throws -> [ProductItem] {
        do {
            let endpoint = SephoraApiEndpoint.getProducts
            
            let results = try await networkService.fetchData(endpoint, type: [ProductItem].self)
            
            return results
        } catch {
            throw SephoraError.productsError(originalError: error)
        }
    }
}
