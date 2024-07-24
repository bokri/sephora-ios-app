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
import RxRelay

enum HomePageState {
    case loading
    case success
    case error
}

class HomePageViewModel {
    
    weak var coordinator: ListViewControllerDelegate?
    var state = PublishSubject<HomePageState>()
    var products = BehaviorRelay<[ProductItem]>(value: [])
    
    private var sephoraService: SephoraServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(sephoraService: SephoraServiceProtocol, coordinator: ListViewControllerDelegate?) {
        self.sephoraService = sephoraService
        self.coordinator = coordinator
    }
    
    func getProducts() async {
        state.onNext(.loading)
        Task {
            do {
                let products = try await sephoraService.getProducts()
                self.products.accept(products)
                state.onNext(.success)
            } catch {
                state.onNext(.error)
            }
        }
    }
    
    func onCellClicked(index: Int) {
        let productItem = products.value[index]
        coordinator?.goToDetailView(productItem: productItem)
    }
    
    func onErrorClicked() async {
        await getProducts()
    }
}
