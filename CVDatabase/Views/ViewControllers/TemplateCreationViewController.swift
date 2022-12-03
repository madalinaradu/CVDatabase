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
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Parameters
    
    var viewModel: TemplateCreationViewModelType?
    static let storyboardName = "TemplateCreation"
    static let identifier = "TemplateCreationViewController"
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        bindViewModel()
    }
    
    // MARK: - IBOutlets
    
    @IBAction func saveTemplateButtonWasTapped(_ sender: Any) {
        print("save template button was tapped")
    }
    
    // MARK: - Instance functions
    
    func bindViewModel() {
        
    }
    
    func configureTableView() {
        tableView.dataSource = self
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
