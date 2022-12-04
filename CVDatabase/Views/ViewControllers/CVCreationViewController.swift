//
//  CVCreationViewController.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class CVCreationViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Parameters
    
    var viewModel: CVCreationViewModelType?
    weak var delegate: CVCreationDelegate?
    weak var coordinator: CVCoordinator?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        bindViewModel()
    }
    
    // MARK: - IBOutlets
    
    @IBAction func saveCVButtonWasTapped(_ sender: Any) {
        viewModel?.saveCV()
    }
    
    // MARK: - Instance functions
    
    func bindViewModel() {
        viewModel?.cvSavingIsComplete.bind { [weak self] isDone in
            guard isDone else {
                return
            }
            
            self?.delegate?.cvWasCreated()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
//        tableView.register(UINib(nibName: CVTypeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CVTypeTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension CVCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: CVTypeTableViewCell.identifier, for: indexPath) as? CVTypeTableViewCell else {
            return UITableViewCell()
//        }
        
//        guard let (templateType, isSelected) = viewModel?.getCVTypeAndSelection(atIndex: indexPath) else {
//            return UITableViewCell()
//        }
        
//        cell.configureWith(templateType, isSelected: isSelected)
//        return cell
    }
}
