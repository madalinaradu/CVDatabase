//
//  TemplatesViewController.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import UIKit

class TemplatesViewController: UIViewController {
    
    // MARK: - Parameters
    
    let dependencyContainer: ServiceDependencyProvider = ServiceDependencyContainer()
    weak var viewModel: TemplatesViewModelType? {
        return TemplatesViewModel(dependencyContainer: dependencyContainer)
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.getAllTemplates()
    }

    // MARK: - Instance functions
    
    func bindViewModel() {
        viewModel?.templates.bind { _ in
            print("Templates were updated")
        }
    }
}

