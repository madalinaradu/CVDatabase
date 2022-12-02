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
                              saveContext: Bool = false) {
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
}
