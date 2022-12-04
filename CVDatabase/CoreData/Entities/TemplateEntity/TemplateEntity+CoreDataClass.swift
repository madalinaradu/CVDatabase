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
        return Template(id: objectID,
                        hasName: hasName,
                        hasPhone: hasPhone,
                        hasEmail: hasEmail,
                        hasAge: hasAge,
                        hasStudies: hasStudies,
                        hasExperience: hasExperience,
                        hasSkills: hasSkills,
                        hasPersonalProjects: hasPersonalProjects)
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
    
    static func deleteAll(context: NSManagedObjectContext = CoreDataContainer.shared.newBackgroundContext()) {
        context.deleteRecords(for: "TemplateEntity", context: context)
    }
    
    static func deleteEntityWithId(of id: NSManagedObjectID,
                                   context: NSManagedObjectContext = CoreDataContainer.shared.newBackgroundContext()) -> Bool {
        do {
            let entity = try context.existingObject(with: id)
            context.delete(entity)
            return true
        } catch {
            return false
        }
    }
}
