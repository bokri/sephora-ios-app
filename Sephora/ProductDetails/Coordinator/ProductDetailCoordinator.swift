//
//  ProductDetailCoordinator.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit
import Entities

protocol ProductDetailViewControllerDelegate: AnyObject {
    func backToListView() // Method to navigate back to the list view
}

final class DetailCoordinator: Coordinator, ParentCoordinator {
    weak var parentCoordinator: Coordinator? // Reference to parent coordinator
    
    private(set) var navigationController: UINavigationController // Navigation controller for managing view controllers
    var childCoordinators = [Coordinator]() // List of child coordinators
    private var productItem: ProductItem // Product item for detail view
    
    // MARK: - Constructor
    
    init(navigationController: UINavigationController, productItem: ProductItem) {
        self.navigationController = navigationController
        self.productItem = productItem
    }
    
    // MARK: - Methods
    
    func start() {
        let viewModel = ProductDetailsViewModel(coordinator: self, productItem: productItem) // Create view model
        let detailViewController = ProductDetailsViewController(viewModel: viewModel) // Create detail view controller
        
        self.navigationController.pushViewController(detailViewController, animated: true) // Navigate to detail view
    }
}

extension DetailCoordinator: ProductDetailViewControllerDelegate {
    func backToListView() {
        parentCoordinator?.removeChildCoordinator(childCoordinator: self) // Remove self as child coordinator
    }
}
