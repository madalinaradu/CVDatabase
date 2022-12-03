//
//  TemplateCreationViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol TemplateCreationViewModelType: AnyObject {
    var template: Template { get }
    
    func getNumberOfRows() -> Int
    func getTemplateTypeAndSelection(atIndex index: IndexPath) -> (templateType: TemplateType, isSelected: Bool)?
}

class TemplateCreationViewModel {
    
    // MARK: - Parameters
    
    private let dependencyContainer: ServiceDependencyProvider
    
    let template: Template = Template(hasName: false,
                                      hasPhone: false,
                                      hasEmail: false,
                                      hasAge: false,
                                      hasStudies: false,
                                      hasExperience: false,
                                      hasSkills: false,
                                      hasPersonalProjects: false)
    
    // MARK: - Initialisers
    
    init(dependencyContainer: ServiceDependencyProvider) {
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
}

