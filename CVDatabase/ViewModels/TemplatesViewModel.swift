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
    func getTemplatesCount() -> Int
    func getTemplate(atIndex: IndexPath) -> Template?
}

class TemplatesViewModel: TemplatesViewModelType {
    // MARK: - Parameters
    
    private let dependencyContainer: ServiceDependencyProvider
    let templates: Observable<[Template]> = .init([])
    
    // MARK: - Initialisers
    
    init(dependencyContainer: ServiceDependencyProvider) {
        self.dependencyContainer = dependencyContainer
        
        self.getAllTemplates()
    }
    
    // MARK: - TemplatesViewModelType
    
    func getAllTemplates() {
        templates.value = dependencyContainer.cvRepository.fetchAllTemplates()
    }
    
    func getTemplatesCount() -> Int {
        return templates.value.count
    }
    
    func getTemplate(atIndex index: IndexPath) -> Template? {
        guard index.row < getTemplatesCount() else {
            return nil
        }
        
        return templates.value[index.row]
    }
}
