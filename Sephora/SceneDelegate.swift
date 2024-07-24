//
//  SceneDelegate.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import UIKit
import SephoraBusiness

/// Handles scene lifecycle events and sets up the initial view controller.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: ListCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Ensure that the scene is of type UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a navigation controller to manage the view hierarchy
        let navigationController = UINavigationController()
        
        // Initialize the service that provides data for the app
        let sephoraService = SephoraService()
        
        // Initialize the coordinator with the navigation controller and service
        coordinator = ListCoordinator(navigationController: navigationController, sephoraService: sephoraService)
        
        // Start the coordinator to set up the initial view controller
        coordinator?.start()
        
        // Create a new window for the app and set its root view controller
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator?.navigationController
        
        // Make the window visible
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
