//
//  BaseCoordinator.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit

import UIKit

/// Defines the common behavior and properties for all coordinators.
protocol Coordinator: AnyObject {
    /// List of child coordinators managed by this coordinator.
    var childCoordinators: [Coordinator] { get set }
    
    /// The navigation controller used to manage the view hierarchy.
    var navigationController: UINavigationController { get }
    
    /// Starts the coordinator and sets up the initial flow.
    func start()
    
    /// Adds a child coordinator to the list.
    /// - Parameter childCoordinator: The coordinator to be added.
    func addChildCoordinator(childCoordinator: Coordinator)
    
    /// Removes a child coordinator from the list.
    /// - Parameter childCoordinator: The coordinator to be removed.
    func removeChildCoordinator(childCoordinator: Coordinator)
}

/// Defines behavior for a coordinator that has a parent.
protocol ParentCoordinator: AnyObject {
    /// The parent coordinator of this coordinator.
    var parentCoordinator: Coordinator? { get }
}

extension Coordinator {
    /// Adds a child coordinator to the list.
    /// - Parameter childCoordinator: The coordinator to be added.
    func addChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Removes a child coordinator from the list.
    /// - Parameter childCoordinator: The coordinator to be removed.
    func removeChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
