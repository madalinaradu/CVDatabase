//
//  CVListViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import Foundation

protocol CVListViewModelType: AnyObject {
    var cvs: Observable<[UserCV]> { get }
    var template: Template { get }
    
    func getAllCVs()
    func getCVsCount() -> Int
    func getCV(atIndex: IndexPath) -> UserCV?
    func removeCV(atIndex: IndexPath)
}

class CVListViewModel {
    
    typealias Dependencies = CVRepositoryProvider
    
    // MARK: - Parameters
    
    private let dependencyContainer: Dependencies
    let cvs: Observable<[UserCV]> = .init([])
    let template: Template
    
    // MARK: - Initialisers
    
    init(dependencyContainer: Dependencies, template: Template) {
        self.dependencyContainer = dependencyContainer
        self.template = template
    }
}

// MARK: - CVsViewModelType

extension CVListViewModel: CVListViewModelType {
    func getAllCVs() {
        let context = CoreDataContainer.shared.newBackgroundContext()
        cvs.value = dependencyContainer.cvRepository.fetchAllCVs(for: template, context: context)
    }
    
    func getCVsCount() -> Int {
        return cvs.value.count
    }
    
    func getCV(atIndex index: IndexPath) -> UserCV? {
        guard index.row < getCVsCount() else {
            return nil
        }
        
        return cvs.value[index.row]
    }
    
    func removeCV(atIndex index: IndexPath) {
        let context = CoreDataContainer.shared.newBackgroundContext()
        let templateWasRemoved = dependencyContainer.cvRepository.removeCV(cvs.value[index.row], context: context)
        guard templateWasRemoved else {
            print("The deletion failed")
            return
        }
        print("The deletion succeeded")
        cvs.value.remove(at: index.row)
    }
}

