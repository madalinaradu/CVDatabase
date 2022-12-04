//
//  CVEntity+CoreDataClass.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//
//

import Foundation
import CoreData


public class CVEntity: NSManagedObject {

}

extension CVEntity {
    // convert to a Data Transfer Object
    func convertToDTO() -> CV {
        return CV(id: objectID,
                  template: template.convertToDTO(),
                  name: name,
                  phone: phone,
                  email: email,
                  age: Int(age),
                  studies: studies,
                  experience: experience,
                  skills: skills,
                  personalProjects: personalProjects)
    }
}
