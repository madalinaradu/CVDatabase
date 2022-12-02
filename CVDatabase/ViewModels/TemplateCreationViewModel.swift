//
//  TemplateCreationViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol TemplateCreationViewModelType: AnyObject {

}

class TemplateCreationViewModel: TemplateCreationViewModelType {
    // MARK: - Parameters
    
    private let dependencyContainer: ServiceDependencyProvider
    
    // MARK: - Initialisers
    
    init(dependencyContainer: ServiceDependencyProvider) {
        self.dependencyContainer = dependencyContainer
    }
    
    // MARK: - TemplateCreationViewModelType
}

