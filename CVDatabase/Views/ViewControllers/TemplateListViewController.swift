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
    
    private let dependencyContainer: ServiceDependencyProvider = ServiceDependencyContainer()
    private lazy var viewModel: TemplateListViewModelType? = {
        return TemplateListViewModel(dependencyContainer: dependencyContainer)
    }()

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
        let vc = TemplateCreationViewController.loadFromNib()
        let viewModel = TemplateCreationViewModel(dependencyContainer: dependencyContainer)
        vc.viewModel = viewModel
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
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
        let vc = CVListViewController.loadFromNib()
        let viewModel = CVListViewModel(dependencyContainer: dependencyContainer)
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TemplateCreationDelegate

extension TemplateListViewController: TemplateCreationDelegate {
    func templateWasCreated() {
        viewModel?.getAllTemplates()
    }
}

