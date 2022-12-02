//
//  TemplateCreationViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol TemplateCreationViewModelType: AnyObject {
    func getNumberOfRows() -> Int
    func getTemplateType(forIndex index: IndexPath) -> TemplateType?
}

class TemplateCreationViewModel {
    
    // MARK: - Parameters
    
    private let dependencyContainer: ServiceDependencyProvider
    
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
    
    func getTemplateType(forIndex index: IndexPath) -> TemplateType? {
        return TemplateType(rawValue: index.row)
    }
}

