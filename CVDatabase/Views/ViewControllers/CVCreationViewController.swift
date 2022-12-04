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
        tableView.delegate = self
        tableView.register(UINib(nibName: SmallCVCreationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SmallCVCreationTableViewCell.identifier)
        tableView.register(UINib(nibName: BigCVCreationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BigCVCreationTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension CVCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        typealias TemplateCompletion = (templateType: TemplateType, isSelectable: Bool)
        guard let templateCompletion: TemplateCompletion = viewModel?.getTemplateType(atIndex: indexPath),
              templateCompletion.isSelectable,
              let cv = viewModel?.cv else {
            return UITableViewCell()
        }
        
        switch templateCompletion.templateType.fieldType {
        case .smallTextInput:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallCVCreationTableViewCell.identifier, for: indexPath) as? SmallCVCreationTableViewCell else {
                return UITableViewCell()
            }
            cell.configureWith(cv, templateType: templateCompletion.templateType)
            return cell
        case .bigTextInput:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BigCVCreationTableViewCell.identifier, for: indexPath) as? BigCVCreationTableViewCell else {
                return UITableViewCell()
            }
            cell.configureWith(cv, templateType: templateCompletion.templateType)
            return cell
        }
    }
}

// MARK: - UITableViewDataSource

extension CVCreationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        typealias TemplateCompletion = (templateType: TemplateType, isSelectable: Bool)
        guard let templateCompletion: TemplateCompletion = viewModel?.getTemplateType(atIndex: indexPath),
              templateCompletion.isSelectable else {
            return 0
        }
        
        switch templateCompletion.templateType.fieldType {
        case .smallTextInput:
            return 100
        case .bigTextInput:
            return 300
        }
    }
}
