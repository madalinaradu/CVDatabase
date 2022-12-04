//
//  TemplateListViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol TemplateListViewModelType: AnyObject {
    var templates: Observable<[Template]> { get }
    
    func getAllTemplates()
    func getTemplatesCount() -> Int
    func getTemplate(atIndex: IndexPath) -> Template?
    func removeTemplate(atIndex: IndexPath)
}

class TemplateListViewModel {
    
    typealias Dependencies = TemplateRepositoryProvider
    
    // MARK: - Parameters
    
    private let dependencyContainer: Dependencies
    let templates: Observable<[Template]> = .init([])
    
    // MARK: - Initialisers
    
    init(dependencyContainer: Dependencies) {
        self.dependencyContainer = dependencyContainer
    }
}

// MARK: - TemplatesViewModelType

extension TemplateListViewModel: TemplateListViewModelType {
    func getAllTemplates() {
        templates.value = dependencyContainer.templateRepository.fetchAllTemplates()
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
    
    func removeTemplate(atIndex index: IndexPath) {
        let templateWasRemoved = dependencyContainer.templateRepository.removeTemplate(templates.value[index.row])
        guard templateWasRemoved else {
            print("The deletion failed")
            return
        }
        print("The deletion succeeded")
        templates.value.remove(at: index.row)
    }
}
