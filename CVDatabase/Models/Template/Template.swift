//
//  Template.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation
import CoreData

class Template {
    var hasName: Bool
    var hasPhone: Bool
    var hasEmail: Bool
    var hasAge: Bool
    var hasStudies: Bool
    var hasExperience: Bool
    var hasSkills: Bool
    var hasPersonalProjects: Bool
    
    init(
        hasName: Bool,
        hasPhone: Bool,
        hasEmail: Bool,
        hasAge: Bool,
        hasStudies: Bool,
        hasExperience: Bool,
        hasSkills: Bool,
        hasPersonalProjects: Bool
    ) {
        self.hasName = hasName
        self.hasPhone = hasPhone
        self.hasEmail = hasEmail
        self.hasAge = hasAge
        self.hasStudies = hasStudies
        self.hasExperience = hasExperience
        self.hasSkills = hasSkills
        self.hasPersonalProjects = hasPersonalProjects
    }
}

extension Template {
    func convertToCoreDataEntity(context: NSManagedObjectContext = CoreDataContainer.shared.newBackgroundContext()) -> TemplateEntity {
        let templateEntity = TemplateEntity(context: context)
        templateEntity.hasName = self.hasName
        templateEntity.hasPhone = self.hasPhone
        templateEntity.hasEmail = self.hasEmail
        templateEntity.hasAge = self.hasAge
        templateEntity.hasStudies = self.hasStudies
        templateEntity.hasExperience = self.hasExperience
        templateEntity.hasSkills = self.hasSkills
        templateEntity.hasPersonalProjects = self.hasPersonalProjects
        return templateEntity
    }
}

extension Template {
    var components: String {
        return "Components: " +
        (hasName ? "Name, " : "") +
        (hasPhone ? "Phone, " : "") +
        (hasEmail ? "Email, " : "") +
        (hasAge ? "Age, " : "") +
        (hasStudies ? "Studies, " : "") +
        (hasExperience ? "Experience, " : "") +
        (hasSkills ? "Skills, " : "") +
        (hasPersonalProjects ? "PersonalProjects" : "")
    }
}

extension Template {
    func getValueForType(_ type: TemplateType) -> Bool {
        switch type {
        case .name:
            return hasName
        case .phone:
            return hasPhone
        case .email:
            return hasEmail
        case .age:
            return hasAge
        case .studies:
            return hasStudies
        case .experience:
            return hasExperience
        case .skills:
            return hasSkills
        case .personalProjects:
            return hasPersonalProjects
        }
    }
    
    func toggleValueForType(_ type: TemplateType) {
        switch type {
        case .name:
            hasName.toggle()
        case .phone:
            hasPhone.toggle()
        case .email:
            hasEmail.toggle()
        case .age:
            hasAge.toggle()
        case .studies:
            hasStudies.toggle()
        case .experience:
            hasExperience.toggle()
        case .skills:
            hasSkills.toggle()
        case .personalProjects:
            hasPersonalProjects.toggle()
        }
    }
}
