//
//  Coordinator.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var dependencyContainer: ServiceDependencyProvider { get set }

    func start()
}
