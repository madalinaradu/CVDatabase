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
    var name: Observable<String?> { get set }
    var phone: Observable<String?> { get set }
    var email: Observable<String?> { get set }
    var age: Observable<Int?> { get set }
    var studies: Observable<String?> { get set }
    var experience: Observable<String?> { get set }
    var skills: Observable<String?> { get set }
    var personalProjects: Observable<String?> { get set }

    func getNumberOfRows() -> Int
    func getTemplateType(atIndex index: IndexPath) -> (templateType: TemplateType, isSelectable: Bool)?

    func saveCV()
}

class CVCreationViewModel {

    typealias Dependencies = CVRepositoryProvider

    // MARK: - Parameters

    private let dependencyContainer: Dependencies

    var cv: UserCV
    
    let template: Template

    var cvSavingIsComplete: Observable<Bool> = .init(false)
    
    /// possible fields
    var name: Observable<String?> = .init(nil)
    var phone: Observable<String?> = .init(nil)
    var email: Observable<String?> = .init(nil)
    var age: Observable<Int?> = .init(nil)
    var studies: Observable<String?> = .init(nil)
    var experience: Observable<String?> = .init(nil)
    var skills: Observable<String?> = .init(nil)
    var personalProjects: Observable<String?> = .init(nil)

    // MARK: - Initialisers

    init(dependencyContainer: Dependencies, template: Template) {
        self.dependencyContainer = dependencyContainer
        self.template = template
        self.cv = UserCV(id: nil,
                         template: template,
                         name: nil,
                         phone: nil,
                         email: nil,
                         age: nil,
                         studies: nil,
                         experience: nil,
                         skills: nil,
                         personalProjects: nil)
    }
    
    init(dependencyContainer: Dependencies, cv: UserCV) {
        self.dependencyContainer = dependencyContainer
        self.cv = cv
        template = cv.template
        name.value = cv.name
        phone.value = cv.phone
        email.value = cv.email
        age.value = cv.age
        studies.value = cv.studies
        experience.value = cv.experience
        skills.value = cv.skills
        personalProjects.value = cv.personalProjects
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

