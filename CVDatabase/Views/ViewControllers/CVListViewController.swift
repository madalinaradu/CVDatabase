//
//  CVListViewController.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class CVListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Parameters
    
    var viewModel: CVListViewModelType?
    var coordinator: CVCoordinator?

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        configureTableView()
        viewModel?.getAllCVs()
        bindViewModel()
    }
    
    // MARK: - Instance functions
    
    private func bindViewModel() {
        viewModel?.cvs.bind { _ in
            print("CVS were updated")
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
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CVTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CVTableViewCell.identifier)
    }
    
    @objc private func addButtonWasTapped() {
        guard let template = coordinator?.template else {
            return
        }
        coordinator?.openCVCreation(from: self, template: template)
    }
}

// MARK: - UITableViewDataSource

extension CVListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCVsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CVTableViewCell.identifier, for: indexPath) as? CVTableViewCell else {
            return UITableViewCell()
        }
        
        guard let cv = viewModel?.getCV(atIndex: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configureWith(cv)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.removeCV(atIndex: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

// MARK: -

extension CVListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cv = viewModel?.cvs.value[indexPath.row] else {
            return
        }
        coordinator?.openCVEditor(from: self, cv: cv)
    }
}

// MARK: - CVCreationDelegate

extension CVListViewController: CVCreationDelegate {
    func cvWasCreated() {
        viewModel?.getAllCVs()
    }
}


