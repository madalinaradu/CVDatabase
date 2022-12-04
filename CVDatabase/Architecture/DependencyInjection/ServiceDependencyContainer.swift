//
//  ServiceDependencyContainer.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol ServiceDependencyProvider: TemplateRepositoryProvider { }

final class ServiceDependencyContainer: ServiceDependencyProvider {
    var templateRepository: TemplateRepository = TemplateRepository()
}

protocol TemplateRepositoryProvider {
    var templateRepository: TemplateRepository { get }
}
