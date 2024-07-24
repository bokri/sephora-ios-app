//
//  HomePageCoordinator.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit
import SephoraBusiness
import Entities

/// Delegate protocol for navigating to product detail view.
protocol ListViewControllerDelegate: AnyObject {
    /// Navigates to the detail view of the selected product.
    /// - Parameter productItem: The product to show details for.
    func goToDetailView(productItem: ProductItem)
}

/// Coordinates navigation and manages child coordinators.
final class ListCoordinator: Coordinator {
    
    /// The navigation controller used for pushing view controllers.
    private(set) var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    /// Service for fetching data.
    private var sephoraService: SephoraServiceProtocol
    
    /// Initializes the coordinator with necessary components.
    /// - Parameters:
    ///   - navigationController: The navigation controller for managing view controllers.
    ///   - sephoraService: Service for fetching product data.
    init(navigationController: UINavigationController, sephoraService: SephoraServiceProtocol) {
        self.navigationController = navigationController
        self.sephoraService = sephoraService
    }
    
    deinit {
        // Clean up resources if needed
    }
    
    /// Sets up the initial view controller and pushes it onto the navigation stack.
    func start() {
        let viewModel = HomePageViewModel(sephoraService: sephoraService, coordinator: self)
        let listViewController = HomePageViewController(viewModel: viewModel)
        navigationController.pushViewController(listViewController, animated: true)
    }
}

extension ListCoordinator: ListViewControllerDelegate {
    /// Navigates to the detail view for a selected product.
    /// - Parameter productItem: The product to display details for.
    func goToDetailView(productItem: ProductItem) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, productItem: productItem)
        detailCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: detailCoordinator)
        
        detailCoordinator.start()
    }
}
