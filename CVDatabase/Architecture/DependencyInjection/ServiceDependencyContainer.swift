//
//  ServiceDependencyContainer.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

protocol ServiceDependencyProvider: CVRepositoryProvider { }

final class ServiceDependencyContainer: ServiceDependencyProvider {
    var cvRepository: CVRepository = CVRepository()
}

protocol CVRepositoryProvider {
    var cvRepository: CVRepository { get }
}
