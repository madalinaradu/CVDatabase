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
    func convertToDTO() -> UserCV {
        return UserCV(id: objectID,
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

extension CVEntity {
//    static func fetchAll(context: NSManagedObjectContext) -> [CVEntity] {
//        let fetchRequest: NSFetchRequest = CVEntity.fetchRequest()
//        do {
//            let fetchResponse = try context.fetch(fetchRequest)
//            return fetchResponse
//        } catch {
//            print("Fetch failed")
//            return []
//        }
//    }
    
    static func fetchAll(for template: Template,
                         context: NSManagedObjectContext) -> [CVEntity] {
        let fetchRequest: NSFetchRequest = CVEntity.fetchRequest()
        do {
            let fetchResponse = try context.fetch(fetchRequest)
            return fetchResponse.filter({ $0.template.objectID == template.id })
        } catch {
            print("Fetch failed")
            return []
        }
    }
    
    static func deleteAll(context: NSManagedObjectContext) {
        context.deleteRecords(for: "CVEntity", context: context)
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
