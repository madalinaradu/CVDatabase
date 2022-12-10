//
//  ServiceDependencyContainer.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol ServiceDependencyProvider: TemplateRepositoryProvider,
                                    CVRepositoryProvider,
                                    CVCreationTableViewCellFactoryProvider
{ }

final class ServiceDependencyContainer: ServiceDependencyProvider {
    var templateRepository: TemplateRepository = TemplateRepository()
    var cvRepository: CVRepository = CVRepository()
    var factory: CVTableViewCellFactoryType = CVTableViewCellFactory()
}

protocol TemplateRepositoryProvider {
    var templateRepository: TemplateRepository { get }
}

protocol CVRepositoryProvider {
    var cvRepository: CVRepository { get }
}

protocol CVCreationTableViewCellFactoryProvider {
    var factory: CVTableViewCellFactoryType { get }
}
