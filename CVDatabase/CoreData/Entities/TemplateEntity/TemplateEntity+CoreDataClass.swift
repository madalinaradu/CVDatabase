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
    static func fetchAll(context: NSManagedObjectContext) -> [TemplateEntity] {
        let fetchRequest: NSFetchRequest = TemplateEntity.fetchRequest()
        do {
            let fetchResponse = try context.fetch(fetchRequest)
            return fetchResponse
        } catch {
            print("Fetch failed")
            return []
        }
    }
    
    static func fetchRecord(withIdOf id: NSManagedObjectID,
                            context: NSManagedObjectContext) -> TemplateEntity? {
        do {
            guard let entity = try context.existingObject(with: id) as? TemplateEntity else {
                return nil
            }
            return entity
        } catch {
            return nil
        }
    }
    
    static func deleteAll(context: NSManagedObjectContext) {
        context.deleteRecords(for: "TemplateEntity", context: context)
    }
    
    static func deleteEntityWithId(of id: NSManagedObjectID,
                                   context: NSManagedObjectContext) -> Bool {
        do {
            let entity = try context.existingObject(with: id)
            context.delete(entity)
            return true
        } catch {
            return false
        }
    }
}
