//
//  SephoraService.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import Entities

public actor SephoraService: SephoraServiceProtocol {
    
    private var networkService: SephoraNetworkServiceProtocol
    private var repository: SephoraRepositoryProtocol
    
    public init(networkService: SephoraNetworkServiceProtocol = SephoraNetworkService(), repository: SephoraRepositoryProtocol = SephoraRepository()) {
        self.networkService = networkService
        self.repository = repository
    }
    
    public func getProducts() async throws -> [ProductItem] {
        let savedProducts = try repository.getProducts()
            .compactMap { model -> ProductItem? in
                return model.toEntity()
            }

        if savedProducts.isEmpty {
            let products = try await networkService.getProducts()
            try repository.addProductItems(products: products)
            return products
                .sorted { $0.isSpecialBrand && !$1.isSpecialBrand }
        } else {
            return savedProducts
        }
    }
}
