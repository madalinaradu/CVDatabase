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
        tableView.register(UINib(nibName: TemplateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TemplateTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource
extension TemplatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.templates.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TemplateTableViewCell.identifier, for: indexPath) as? TemplateTableViewCell else {
            return UITableViewCell()
        }
        
        guard let template = viewModel?.getTemplate(atIndex: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configureWith(template)
        return cell
    }
}

