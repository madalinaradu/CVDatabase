//
//  SceneDelegate.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: TemplateCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Initial screen setup
        /// 1. Capture the scene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        /// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
        window = UIWindow(windowScene: windowScene)
        
        /// 3.  Create the main navigation controller
        let navController = UINavigationController()
        
        /// 4. set the navigation controller as the rootviewcontroller
        window?.rootViewController = navController
        
        /// 5. create the main instance of the dependency container
        /// this will be passed in the entire app through dependency injection
        let dependencyCointainer = ServiceDependencyContainer()
        
        /// 6. create the main coordinator
        coordinator = TemplateCoordinator(navigationController: navController,
                                          dependencyContainer: dependencyCointainer)
        
        /// 7. tell the coordinator to take over control
        coordinator?.start()
        
        /// 8. Show the window
        window?.makeKeyAndVisible()
        
        // Core Data setup
        CoreDataContainer.shared.setup()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        do {
            try CoreDataContainer.shared.viewContext.saveIfNeeded()
        } catch {
            assertionFailure("Saving failed with error: \(error)")
        }
    }


}

