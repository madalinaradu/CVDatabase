//
//  CVRepository.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import Foundation
import CoreData

protocol CVRepositoryType {
    func fetchAllTemplates() -> [Template]
    func saveTemplate(_ template: Template,
                              context: NSManagedObjectContext,
                              saveContext: Bool)
    func removeTemplate(_ template: Template,
                        context: NSManagedObjectContext,
                        saveContext: Bool) -> Bool
}

final class CVRepository {
    func fetchAllTemplates() -> [Template] {
        return fetchAllTemplatesFromDB().map({ $0.convertToDTO() })
    }
    
    private func fetchAllTemplatesFromDB() -> [TemplateEntity] {
        return TemplateEntity.fetchAll()
    }
    
    func saveTemplate(_ template: Template,
                              context: NSManagedObjectContext = CoreDataContainer.shared.newBackgroundContext(),
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
                              context: NSManagedObjectContext = CoreDataContainer.shared.newBackgroundContext()) -> Bool {
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
