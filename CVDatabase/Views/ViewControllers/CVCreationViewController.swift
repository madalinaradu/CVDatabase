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
        
        viewModel?.name.bind { [weak self] name in
            guard let self = self else { return }
            self.viewModel?.cv.name = name
        }
        viewModel?.phone.bind { [weak self] phone in
            guard let self = self else { return }
            self.viewModel?.cv.phone = phone
        }
        viewModel?.email.bind { [weak self] email in
            guard let self = self else { return }
            self.viewModel?.cv.email = email
        }
        viewModel?.age.bind { [weak self] age in
            guard let self = self else { return }
            self.viewModel?.cv.age = age
        }
        viewModel?.studies.bind { [weak self] studies in
            guard let self = self else { return }
            self.viewModel?.cv.studies = studies
        }
        viewModel?.experience.bind { [weak self] experience in
            guard let self = self else { return }
            self.viewModel?.cv.experience = experience
        }
        viewModel?.skills.bind { [weak self] skills in
            guard let self = self else { return }
            self.viewModel?.cv.skills = skills
        }
        viewModel?.personalProjects.bind { [weak self] personalProjects in
            guard let self = self else { return }
            self.viewModel?.cv.personalProjects = personalProjects
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
            cell.delegate = self
            return cell
        case .bigTextInput:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BigCVCreationTableViewCell.identifier, for: indexPath) as? BigCVCreationTableViewCell else {
                return UITableViewCell()
            }
            cell.configureWith(cv, templateType: templateCompletion.templateType)
            cell.delegate = self
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

// MARK: - CVFieldCompletion

extension CVCreationViewController: CVFieldCompletion {
    func fieldUpdated(withText text: String, for templateType: TemplateType) {
        switch templateType {
        case .name:
            viewModel?.name.value = text
        case .phone:
            viewModel?.phone.value = text
        case .email:
            viewModel?.email.value = text
        case .age:
            viewModel?.age.value = Int(text)
        case .studies:
            viewModel?.studies.value = text
        case .experience:
            viewModel?.experience.value = text
        case .skills:
            viewModel?.skills.value = text
        case .personalProjects:
            viewModel?.personalProjects.value = text
        }
    }
}
