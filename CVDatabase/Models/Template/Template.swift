//
//  Template.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

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
