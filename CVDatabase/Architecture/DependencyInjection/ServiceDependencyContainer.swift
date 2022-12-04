//
//  ServiceDependencyContainer.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol ServiceDependencyProvider: TemplateRepositoryProvider,
                                    CVRepositoryProvider
{ }

final class ServiceDependencyContainer: ServiceDependencyProvider {
    var templateRepository: TemplateRepository = TemplateRepository()
    var cvRepository: CVRepository = CVRepository()
}

protocol TemplateRepositoryProvider {
    var templateRepository: TemplateRepository { get }
}

protocol CVRepositoryProvider {
    var cvRepository: CVRepository { get }
}
