//
//  TemplateCoordinator.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class TemplateCoordinator: Coordinator {
    var navigationController: UINavigationController
    var dependencyContainer: ServiceDependencyContainer

    init(navigationController: UINavigationController,
         dependencyContainer: ServiceDependencyContainer) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let vc = TemplateListViewController.loadFromNib()
        let vm = TemplateListViewModel(dependencyContainer: dependencyContainer)
        vc.viewModel = vm
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openTemplateCreation(from templateListViewController: TemplateCreationDelegate) {
        let vc = TemplateCreationViewController.loadFromNib()
        let viewModel = TemplateCreationViewModel(dependencyContainer: dependencyContainer)
        vc.viewModel = viewModel
        vc.coordinator = self
        vc.delegate = templateListViewController
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCVChildCoordinator() {
        let coordinator = CVCoordinator(navigationController: navigationController,
                                        dependencyContainer: dependencyContainer)
        coordinator.start()
    }
}
