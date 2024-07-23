//
//  SephoraService.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

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
                guard let productName = model.productName,
                      let productDescription = model.productDescription,
                      let smallImage = model.imagesUrl?.small,
                      let brand = model.cBrand,
                      let brandId = brand.id,
                      let brandName = brand.name
                else { return nil }
                
                return ProductItem(
                    productId: model.productId,
                    productName: productName,
                    description: productDescription,
                    price: model.price,
                    imagesUrl: model.imagesUrl.map({ model in
                        return ImagesUrl(small: smallImage, large: model.large)
                    }),
                    cBrand: Brand(id: brandId, name: brandName),
                    isSpecialBrand: model.isSpecialBrand
                )
            }
        
        if savedProducts.isEmpty {
            let products = try await networkService.getProducts()
            try repository.addProductItems(products: products)
            print("From Network")
            return products
        } else {
            print("From DB")
            return savedProducts
        }
    }
}
