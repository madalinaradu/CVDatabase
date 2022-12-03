//
//  Template.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation
import CoreData

class Template {
    let hasName: Bool
    let hasPhone: Bool
    let hasEmail: Bool
    let hasAge: Bool
    let hasStudies: Bool
    let hasExperience: Bool
    let hasSkills: Bool
    let hasPersonalProjects: Bool
    
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
            return self.hasName
        case .phone:
            return self.hasPhone
        case .email:
            return self.hasEmail
        case .age:
            return self.hasAge
        case .studies:
            return self.hasStudies
        case .experience:
            return self.hasExperience
        case .skills:
            return self.hasSkills
        case .personalProjects:
            return self.hasPersonalProjects
        }
    }
}
