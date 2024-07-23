//
//  ProductDetailCoordinator.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit

protocol ProductDetailViewControllerDelegate: AnyObject {
    func backToListView()
}

final class DetailCoordinator: Coordinator, ParentCoordinator {
    weak var parentCoordinator: Coordinator?
    
    private(set) var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    let viewModel: ProductDetailsViewModel
    
    init(navigationController : UINavigationController, viewModel: ProductDetailsViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let detailViewController = ProductDetailsViewController()
        detailViewController.configure(viewModel: viewModel)
        detailViewController.coordinator = self
        
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension DetailCoordinator: ProductDetailViewControllerDelegate {
    func backToListView() {
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
    }
}
