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
    func backToListView()
}

final class DetailCoordinator: Coordinator, ParentCoordinator {
    weak var parentCoordinator: Coordinator?
    
    private(set) var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    private var productItem: ProductItem
    
    
    init(navigationController : UINavigationController, productItem: ProductItem) {
        self.navigationController = navigationController
        self.productItem = productItem
    }
    
    func start() {
        let viewModel = ProductDetailsViewModel(coordinator: self, productItem: productItem)
        let detailViewController = ProductDetailsViewController(viewModel: viewModel)
        
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension DetailCoordinator: ProductDetailViewControllerDelegate {
    func backToListView() {
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
    }
}
