//
//  CVCoordinator.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class CVCoordinator: Coordinator {
    var navigationController: UINavigationController
    var dependencyContainer: ServiceDependencyProvider
    let template: Template

    init(navigationController: UINavigationController,
         dependencyContainer: ServiceDependencyProvider,
         template: Template) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
        self.template = template
    }

    func start() {
        let vc = CVListViewController.loadFromNib()
        let vm = CVListViewModel(dependencyContainer: dependencyContainer,
                                 template: template)
        vc.viewModel = vm
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCVCreation(from cvListViewController: CVCreationDelegate, template: Template) {
        let vc = CVCreationViewController.loadFromNib()
        let viewModel = CVCreationViewModel(dependencyContainer: dependencyContainer,
                                            template: template)
        vc.viewModel = viewModel
        vc.coordinator = self
        vc.delegate = cvListViewController
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCVEditor(from cvListViewController: CVCreationDelegate, cv: UserCV) {
        let vc = CVCreationViewController.loadFromNib()
        let viewModel = CVCreationViewModel(dependencyContainer: dependencyContainer,
                                            cv: cv)
        vc.viewModel = viewModel
        vc.coordinator = self
        vc.delegate = cvListViewController
        navigationController.pushViewController(vc, animated: true)
    }
}
