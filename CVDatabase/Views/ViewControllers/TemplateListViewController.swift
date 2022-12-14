//
//  TemplateListViewController.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import UIKit

class TemplateListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Parameters
    
    var viewModel: TemplateListViewModelType?
    weak var coordinator: TemplateCoordinator?

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        configureTableView()
        viewModel?.getAllTemplates()
        bindViewModel()
    }
    
    // MARK: - Instance functions
    
    private func bindViewModel() {
        viewModel?.templates.bind { _ in
            print("Templates were updated")
            self.tableView.reloadData()
        }
    }
    
    private func configureNavigationItems() {
        let addTemplateBarButtonItem = UIBarButtonItem(title: "+",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(addButtonWasTapped))
        self.navigationItem.rightBarButtonItem  = addTemplateBarButtonItem
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TemplateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TemplateTableViewCell.identifier)
    }
    
    @objc private func addButtonWasTapped() {
        coordinator?.openTemplateCreation(from: self)
    }
}

// MARK: - UITableViewDataSource

extension TemplateListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getTemplatesCount() ?? 0
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.removeTemplate(atIndex: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

// MARK: - UITableViewDelegate

extension TemplateListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let templates = viewModel?.templates.value,
              templates.count > indexPath.row else {
            return
        }
        coordinator?.openCVChildCoordinator(fromTemplate: templates[indexPath.row])
    }
}

// MARK: - TemplateCreationDelegate

extension TemplateListViewController: TemplateCreationDelegate {
    func templateWasCreated() {
        viewModel?.getAllTemplates()
    }
}

