//
//  HomePageCoordinator.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func goToDetailView()
}

final class ListCoordinator: Coordinator {
    
    private(set) var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("deinit 1")
    }
    
    // Définition du point d'entrée
    func start() {
        let listViewController = HomePageViewController()
        listViewController.coordinator = self
        
        listViewController.configure(viewModel: HomePageViewModel())
        
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
