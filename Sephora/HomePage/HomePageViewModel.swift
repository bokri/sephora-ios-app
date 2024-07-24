//
//  HomePageViewModel.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import Entities
import SephoraBusiness
import RxSwift

enum HomePageState {
    case loading
    case success
    case error
}

class HomePageViewModel {

    var state = PublishSubject<HomePageState>()
    var products = PublishSubject<[ProductItem]>()
    
    private var sephoraService: SephoraServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(sephoraService: SephoraServiceProtocol) {
        self.sephoraService = sephoraService
    }
    
    func getProducts() async {
        state.onNext(.loading)
        Task {
            do {
                let products = try await sephoraService.getProducts()
                self.products.onNext(products)
                state.onNext(.success)
            } catch {
                state.onNext(.error)
            }
        }
    }
    
    func onErrorClicked() async {
        await getProducts()
    }
}
