//
//  TemplateType.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation

enum TemplateType: Int, CaseIterable {
    case name = 1
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
}
