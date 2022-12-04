//
//  CVCreationViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

//import Foundation
//
//protocol CVCreationViewModelType: AnyObject {
//    var cv: CV { get }
//    var cvSavingIsComplete: Observable<Bool> { get }
//    
//    func getNumberOfRows() -> Int
//    func getCVTypeAndSelection(atIndex index: IndexPath) -> (cvType: CVType, isSelected: Bool)?
//    func toggleTypeStatus(for index: IndexPath)
//    
//    func saveCV()
//}
//
//class CVCreationViewModel {
//    
//    typealias Dependencies = CVRepositoryProvider
//    
//    // MARK: - Parameters
//    
//    private let dependencyContainer: Dependencies
//    
//    let cv: CV = CV(id: nil,
//                    template: nil,
//                    name: nil,
//                    phone: nil,
//                    email: nil,
//                    age: nil,
//                    studies: nil,
//                    experience: nil,
//                    skills: nil,
//                    personalProjects: nil)
//    
//    var cvSavingIsComplete: Observable<Bool> = .init(false)
//    
//    // MARK: - Initialisers
//    
//    init(dependencyContainer: Dependencies) {
//        self.dependencyContainer = dependencyContainer
//    }
//}
//
//// MARK: - CVCreationViewModelType
//
//extension CVCreationViewModel: CVCreationViewModelType {
//    func getNumberOfRows() -> Int {
//        return CVType.allCases.count
//    }
//    
//    func getCVTypeAndSelection(atIndex index: IndexPath) -> (cvType: CVType, isSelected: Bool)? {
//        guard let cvType = CVType(rawValue: index.row) else {
//            return nil
//        }
//        
//        let isSelected = cv.getValueForType(cvType)
//        
//        return (cvType, isSelected)
//    }
//    
//    func toggleTypeStatus(for index: IndexPath) {
//        guard let cvType = CVType(rawValue: index.row) else {
//            return
//        }
//        
//        cv.toggleValueForType(cvType)
//    }
//    
//    func saveCV() {
//        dependencyContainer.cvRepository.saveCV(cv)
//        cvSavingIsComplete.value = true
//    }
//}
//
