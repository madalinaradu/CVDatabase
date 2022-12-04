//
//  TemplateRepository.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation
import CoreData

protocol TemplateRepositoryType {
    func fetchAllTemplates() -> [Template]
    func saveTemplate(_ template: Template,
                              context: NSManagedObjectContext,
                              saveContext: Bool)
    func removeTemplate(_ template: Template,
                        context: NSManagedObjectContext,
                        saveContext: Bool) -> Bool
}

final class TemplateRepository {
    func fetchAllTemplates(context: NSManagedObjectContext) -> [Template] {
        return fetchAllTemplatesFromDB(context: context).map({ $0.convertToDTO() })
    }
    
    private func fetchAllTemplatesFromDB(context: NSManagedObjectContext) -> [TemplateEntity] {
        return TemplateEntity.fetchAll(context: context)
    }
    
    func saveTemplate(_ template: Template,
                              context: NSManagedObjectContext,
                              saveContext: Bool = true) {
        let _ = template.convertToCoreDataEntity(context: context)
        guard saveContext else {
            return
        }
        do {
            try context.saveIfNeeded()
        } catch {
            print("Save failed")
        }
    }
    
    func removeTemplate(_ template: Template,
                              context: NSManagedObjectContext) -> Bool {
        guard let id = template.id else {
            return false
        }
        guard TemplateEntity.deleteEntityWithId(of: id, context: context) else {
            return false
        }
        do {
            try context.saveIfNeeded()
            print("Saving context after deleting succeeded")
            return true
        } catch {
            print("Saving context after deleting failed")
            return false
        }
    }
}
