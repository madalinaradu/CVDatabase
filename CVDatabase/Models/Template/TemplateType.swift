//
//  TemplateType.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

enum TemplateType: Int, CaseIterable {
    case name = 0
    case phone
    case email
    case age
    case studies
    case experience
    case skills
    case personalProjects
    
    var fieldType: TemplateFieldType {
        switch self {
        case .name, .phone, .email, .age:
            return .smallTextInput
        case .studies, .experience, .skills, .personalProjects:
            return .bigTextInput
        }
    }
    
    var name: String {
        switch self {
        case .name:
            return "Name"
        case .phone:
            return "Phone"
        case .email:
            return "Email"
        case .age:
            return "Age"
        case .studies:
            return "Studies"
        case .experience:
            return "Experience"
        case .skills:
            return "Skills"
        case .personalProjects:
            return "Personal Projects"
        }
    }
}
