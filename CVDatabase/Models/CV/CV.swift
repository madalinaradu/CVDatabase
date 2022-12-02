//
//  CV.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

class CV {
    let template: Template
    let name: String?
    let phone: String?
    let email: String?
    let age: Int?
    let studies: String?
    let experience: String?
    let skills: String?
    let personalProjects: String?
    
    init(
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
