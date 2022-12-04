//
//  CVListViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import Foundation

protocol CVListViewModelType: AnyObject {
    var cvs: Observable<[CV]> { get }
    
    func getAllCVs()
    func getCVsCount() -> Int
    func getCV(atIndex: IndexPath) -> CV?
    func removeCV(atIndex: IndexPath)
}

class CVListViewModel {
    
    // MARK: - Parameters
    
    private let dependencyContainer: ServiceDependencyProvider
    let cvs: Observable<[CV]> = .init([])
    
    // MARK: - Initialisers
    
    init(dependencyContainer: ServiceDependencyProvider) {
        self.dependencyContainer = dependencyContainer
    }
}

// MARK: - CVsViewModelType

extension CVListViewModel: CVListViewModelType {
    func getAllCVs() {
//        cvs.value = dependencyContainer.templateRepository.fetchAllCVs()
    }
    
    func getCVsCount() -> Int {
        return cvs.value.count
    }
    
    func getCV(atIndex index: IndexPath) -> CV? {
        guard index.row < getCVsCount() else {
            return nil
        }
        
        return cvs.value[index.row]
    }
    
    func removeCV(atIndex index: IndexPath) {
//        let templateWasRemoved = dependencyContainer.templateRepository.removeCV(cvs.value[index.row])
//        guard templateWasRemoved else {
//            print("The deletion failed")
//            return
//        }
//        print("The deletion succeeded")
//        cvs.value.remove(at: index.row)
    }
}

