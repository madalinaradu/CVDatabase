//
//  CVCreationViewModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import Foundation

protocol CVCreationViewModelType: AnyObject {
    var cv: UserCV { get }
    var template: Template { get }
    var cvSavingIsComplete: Observable<Bool> { get }

    func getNumberOfRows() -> Int
    func getTemplateType(atIndex index: IndexPath) -> (templateType: TemplateType, isSelectable: Bool)?

    func saveCV()
}

class CVCreationViewModel {

    typealias Dependencies = CVRepositoryProvider

    // MARK: - Parameters

    private let dependencyContainer: Dependencies

    lazy var cv: UserCV = {
        return UserCV(id: nil,
                  template: template,
                  name: nil,
                  phone: nil,
                  email: nil,
                  age: nil,
                  studies: nil,
                  experience: nil,
                  skills: nil,
                  personalProjects: nil)
    }()
    
    let template: Template

    var cvSavingIsComplete: Observable<Bool> = .init(false)

    // MARK: - Initialisers

    init(dependencyContainer: Dependencies, template: Template) {
        self.dependencyContainer = dependencyContainer
        self.template = template
    }
}

// MARK: - CVCreationViewModelType

extension CVCreationViewModel: CVCreationViewModelType {
    func getNumberOfRows() -> Int {
        return TemplateType.allCases.count
    }

    func getTemplateType(atIndex index: IndexPath) -> (templateType: TemplateType, isSelectable: Bool)? {
        guard let templateType = TemplateType(rawValue: index.row) else {
            return nil
        }

        let isSelectable = cv.template.getValueForType(templateType)

        return (templateType, isSelectable)
    }

    func saveCV() {
        let context = CoreDataContainer.shared.newBackgroundContext()
        dependencyContainer.cvRepository.saveCV(cv, context: context)
        cvSavingIsComplete.value = true
    }
}

