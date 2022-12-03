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
    lazy var viewModel: TemplatesViewModelType? = {
        return TemplatesViewModel(dependencyContainer: dependencyContainer)
    }()
    static let storyboardName = "Main"
    static let identifier = "TemplatesViewController"

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        viewModel?.getAllTemplates()
        bindViewModel()
    }

    // MARK: - IBOutlets
    
    @IBAction func addButtonWasTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: TemplateCreationViewController.storyboardName, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: TemplateCreationViewController.identifier) as? TemplateCreationViewController else {
            return
        }
        let viewModel = TemplateCreationViewModel(dependencyContainer: dependencyContainer)
        controller.viewModel = viewModel
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
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

// MARK: - TemplateCreationDelegate

extension TemplatesViewController: TemplateCreationDelegate {
    func templateWasCreated() {
        viewModel?.getAllTemplates()
    }
}

