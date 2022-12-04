//
//  TemplateCreationViewController.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import UIKit

class TemplateCreationViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Parameters
    
    var viewModel: TemplateCreationViewModelType?
    var delegate: TemplateCreationDelegate?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        bindViewModel()
    }
    
    // MARK: - IBOutlets
    
    @IBAction func saveTemplateButtonWasTapped(_ sender: Any) {
        viewModel?.saveTemplate()
    }
    
    // MARK: - Instance functions
    
    func bindViewModel() {
        viewModel?.templateSavingIsComplete.bind { [weak self] isDone in
            guard isDone else {
                return
            }
            
            self?.delegate?.templateWasCreated()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: TemplateTypeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TemplateTypeTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension TemplateCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TemplateTypeTableViewCell.identifier, for: indexPath) as? TemplateTypeTableViewCell else {
            return UITableViewCell()
        }
        
        guard let (templateType, isSelected) = viewModel?.getTemplateTypeAndSelection(atIndex: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configureWith(templateType, isSelected: isSelected)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TemplateCreationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.toggleTypeStatus(for: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
