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
        return CV(template: self.template.convertToDTO(),
                  name: self.name,
                  phone: self.phone,
                  email: self.email,
                  age: Int(self.age),
                  studies: self.studies,
                  experience: self.experience,
                  skills: self.skills,
                  personalProjects: self.personalProjects)
    }
}
