//
//  SephoraNetworkService.swift
//
//
//  Created by Aymen Bokri on 20/06/2024.
//

import Foundation
import Entities

public actor SephoraNetworkService: SephoraNetworkServiceProtocol {
    
    // MARK: - Properties
    
    private var networkService: NetworkServiceProtocol
    
    // MARK: - Initialization
    
    public init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    
    /// Fetches products from the network.
    public func getProducts() async throws -> [ProductItem] {
        do {
            let endpoint = SephoraApiEndpoint.getProducts
            let results = try await networkService.fetchData(endpoint, type: [ProductItem].self)
            return results
        } catch {
            Logger.error("Network error fetching products: \(error.localizedDescription)")
            throw SephoraError.productsError(originalError: error)
        }
    }
}
