//
//  TemplateEntity+CoreDataClass.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//
//

import Foundation
import CoreData


public class TemplateEntity: NSManagedObject {

}

extension TemplateEntity {
    // convert to a Data Transfer Object
    func convertToDTO() -> Template {
        return Template(hasName: self.hasName,
                        hasPhone: self.hasPhone,
                        hasEmail: self.hasEmail,
                        hasAge: self.hasAge,
                        hasStudies: self.hasStudies,
                        hasExperience: self.hasExperience,
                        hasSkills: self.hasSkills,
                        hasPersonalProjects: self.hasPersonalProjects)
    }
}

extension TemplateEntity {
    static func fetchAll(context: NSManagedObjectContext = CoreDataContainer.shared.newBackgroundContext()) -> [TemplateEntity] {
        let fetchRequest: NSFetchRequest = TemplateEntity.fetchRequest()
        do {
            let fetchResponse = try context.fetch(fetchRequest)
            return fetchResponse
        } catch {
            print("Fetch failed")
            return []
        }
    }
}
