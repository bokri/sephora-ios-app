//
//  HomePageCoordinator.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit
import SephoraBusiness

protocol ListViewControllerDelegate: AnyObject {
    func goToDetailView()
}

final class ListCoordinator: Coordinator {
    
    private(set) var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    let sephoraService = SephoraService()
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
    }
    
    // Définition du point d'entrée
    func start() {
        let viewModel = HomePageViewModel(sephoraService: sephoraService)
        let listViewController = HomePageViewController(coordinator: self, viewModel: viewModel)
        navigationController.pushViewController(listViewController, animated: true)
    }
}

extension ListCoordinator: ListViewControllerDelegate {
    func goToDetailView() {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, viewModel: ProductDetailsViewModel())
        detailCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: detailCoordinator)
        
        detailCoordinator.start()
    }
}
