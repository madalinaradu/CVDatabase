//
//  TemplatesViewController.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import UIKit

class TemplatesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Parameters
    
    let dependencyContainer: ServiceDependencyProvider = ServiceDependencyContainer()
    weak var viewModel: TemplatesViewModelType? {
        return TemplatesViewModel(dependencyContainer: dependencyContainer)
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        viewModel?.getAllTemplates()
    }

    // MARK: - Instance functions
    
    func bindViewModel() {
        viewModel?.templates.bind { _ in
            print("Templates were updated")
            self.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension TemplatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.templates.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

