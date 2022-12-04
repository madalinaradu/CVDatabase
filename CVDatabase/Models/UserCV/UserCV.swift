//
//  UserCV.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation
import CoreData

class UserCV {
    var id: NSManagedObjectID?
    var template: Template
    var name: String?
    var phone: String?
    var email: String?
    var age: Int?
    var studies: String?
    var experience: String?
    var skills: String?
    var personalProjects: String?
    
    init(
        id: NSManagedObjectID?,
        template: Template,
        name: String?,
        phone: String?,
        email: String?,
        age: Int?,
        studies: String?,
        experience: String?,
        skills: String?,
        personalProjects: String?
    ) {
        self.id = id
        self.template = template
        self.name = name
        self.phone = phone
        self.email = email
        self.age = age
        self.studies = studies
        self.experience = experience
        self.skills = skills
        self.personalProjects = personalProjects
    }
}

extension UserCV {
    func convertToCoreDataEntity(context: NSManagedObjectContext = CoreDataContainer.shared.newBackgroundContext()) -> CVEntity? {
        let cvEntity = CVEntity(context: context)
        cvEntity.name = self.name
        cvEntity.phone = self.phone
        cvEntity.email = self.email
        if let age = self.age {
            cvEntity.age = Int16(age)
        }
        cvEntity.studies = self.studies
        cvEntity.experience = self.experience
        cvEntity.skills = self.skills
        cvEntity.personalProjects = self.personalProjects
        
        guard let templateId = template.id,
              let templateEntity = TemplateEntity.fetchRecord(withIdOf: templateId, context: context) else {
            return nil
        }
        
        cvEntity.template = templateEntity
        return cvEntity
    }
}

extension UserCV {
    func getValueForType(_ templateType: TemplateType) -> String {
        switch templateType {
        case .name:
            return name ?? ""
        case .phone:
            return phone ?? ""
        case .email:
            return email ?? ""
        case .age:
            guard let age = age else {
                return ""
            }
            return String(age)
        case .studies:
            return studies ?? ""
        case .experience:
            return experience ?? ""
        case .skills:
            return skills ?? ""
        case .personalProjects:
            return personalProjects ?? ""
        }
    }
}
