//
//  CVCoordinator.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class CVCoordinator: Coordinator {
    var navigationController: UINavigationController
    var dependencyContainer: ServiceDependencyContainer

    init(navigationController: UINavigationController,
         dependencyContainer: ServiceDependencyContainer) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let vc = CVListViewController.loadFromNib()
        let vm = CVListViewModel(dependencyContainer: dependencyContainer)
        vc.viewModel = vm
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCVCreation(from cvListViewController: CVCreationDelegate) {
//        let vc = CVCreationViewController.loadFromNib()
//        let viewModel = CVCreationViewModel(dependencyContainer: dependencyContainer)
//        vc.viewModel = viewModel
//        vc.coordinator = self
//        vc.delegate = cvListViewController
//        navigationController.pushViewController(vc, animated: true)
    }
}
