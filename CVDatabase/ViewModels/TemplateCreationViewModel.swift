//
//  TemplateCreationViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol TemplateCreationViewModelType: AnyObject {
    var template: Template { get }
    var templateSavingIsComplete: Observable<Bool> { get }
    
    func getNumberOfRows() -> Int
    func getTemplateTypeAndSelection(atIndex index: IndexPath) -> (templateType: TemplateType, isSelected: Bool)?
    func toggleTypeStatus(for index: IndexPath)
    
    func saveTemplate()
}

class TemplateCreationViewModel {
    
    typealias Dependencies = TemplateRepositoryProvider
    
    // MARK: - Parameters
    
    private let dependencyContainer: Dependencies
    
    let template: Template = Template(id: nil,
                                      hasName: false,
                                      hasPhone: false,
                                      hasEmail: false,
                                      hasAge: false,
                                      hasStudies: false,
                                      hasExperience: false,
                                      hasSkills: false,
                                      hasPersonalProjects: false)
    
    var templateSavingIsComplete: Observable<Bool> = .init(false)
    
    // MARK: - Initialisers
    
    init(dependencyContainer: Dependencies) {
        self.dependencyContainer = dependencyContainer
    }
}

// MARK: - TemplateCreationViewModelType

extension TemplateCreationViewModel: TemplateCreationViewModelType {
    func getNumberOfRows() -> Int {
        return TemplateType.allCases.count
    }
    
    func getTemplateTypeAndSelection(atIndex index: IndexPath) -> (templateType: TemplateType, isSelected: Bool)? {
        guard let templateType = TemplateType(rawValue: index.row) else {
            return nil
        }
        
        let isSelected = template.getValueForType(templateType)
        
        return (templateType, isSelected)
    }
    
    func toggleTypeStatus(for index: IndexPath) {
        guard let templateType = TemplateType(rawValue: index.row) else {
            return
        }
        
        template.toggleValueForType(templateType)
    }
    
    func saveTemplate() {
        let context = CoreDataContainer.shared.newBackgroundContext()
        dependencyContainer.templateRepository.saveTemplate(template, context: context)
        templateSavingIsComplete.value = true
    }
}

