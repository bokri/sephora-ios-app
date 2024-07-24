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

protocol ListViewControllerDelegate: AnyObject {
    func goToDetailView(productItem: ProductItem)
}

final class ListCoordinator: Coordinator {
    
    private(set) var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    private var sephoraService: SephoraServiceProtocol
    
    init(navigationController : UINavigationController, sephoraService: SephoraServiceProtocol) {
        self.navigationController = navigationController
        self.sephoraService = sephoraService
    }

    deinit {
    }
    
    // Définition du point d'entrée
    func start() {
        let viewModel = HomePageViewModel(sephoraService: sephoraService, coordinator: self)
        let listViewController = HomePageViewController(viewModel: viewModel)
        navigationController.pushViewController(listViewController, animated: true)
    }
}

extension ListCoordinator: ListViewControllerDelegate {
    func goToDetailView(productItem: ProductItem) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, productItem: productItem)
        detailCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: detailCoordinator)
        
        detailCoordinator.start()
    }
}
