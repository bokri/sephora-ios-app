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

/// ViewModel for managing the home page data and state.
class HomePageViewModel {
    
    // MARK: - Properties
    
    /// Observable for tracking the state of the HomePage view.
    var state = PublishSubject<HomePageState>()
    
    /// Relay containing the list of products.
    var products = BehaviorRelay<[ProductItem]>(value: [])
    
    /// Delegate for coordinating with other parts of the app.
    private weak var coordinator: ListViewControllerDelegate?
    
    /// Service for fetching products.
    private var sephoraService: SephoraServiceProtocol
    
    /// Dispose bag for managing RxSwift subscriptions.
    private let disposeBag = DisposeBag()
    
    // MARK: - Constructor
    
    /// Initializes the view model with the given service and coordinator.
    /// - Parameters:
    ///   - sephoraService: The service used for fetching products.
    ///   - coordinator: The delegate for coordinating view actions.
    init(sephoraService: SephoraServiceProtocol, coordinator: ListViewControllerDelegate?) {
        self.sephoraService = sephoraService
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    
    /// Fetches products from the service and updates the view state.
    func getProducts() async {
        state.onNext(.loading) // Notify that loading has started
        Task {
            do {
                // Fetch products from the service
                let products = try await sephoraService.getProducts()
                
                // Update the products relay and state
                self.products.accept(products)
                state.onNext(.success) // Notify that loading succeeded
            } catch {
                // Notify that an error occurred
                state.onNext(.error)
            }
        }
    }
    
    /// Handles the event when a cell is clicked.
    /// - Parameter index: The index of the clicked cell.
    func onCellClicked(index: Int) {
        let productItem = products.value[index]
        coordinator?.goToDetailView(productItem: productItem)
    }
    
    /// Handles the event when the error state is clicked, and retries fetching products.
    func onErrorClicked() async {
        await getProducts()
    }
}
