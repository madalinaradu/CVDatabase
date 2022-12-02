//
//  TemplatesViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol TemplatesViewModelType: AnyObject {
    var templates: Observable<[Template]> { get }
    
    func getAllTemplates()
}

class TemplatesViewModel: TemplatesViewModelType {
    let dependencyContainer: ServiceDependencyProvider
    let templates: Observable<[Template]> = .init([])
    
    init(dependencyContainer: ServiceDependencyProvider) {
        self.dependencyContainer = dependencyContainer
    }
    
    func getAllTemplates() {
        templates.value = dependencyContainer.cvRepository.fetchAllTemplates()
    }
}
