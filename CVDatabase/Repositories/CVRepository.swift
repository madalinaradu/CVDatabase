//
//  CVRepository.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import Foundation
import CoreData

protocol CVRepositoryType {
    func fetchAllCVs(for template: Template) -> [UserCV]
    func saveCV(_ cv: UserCV,
                              context: NSManagedObjectContext,
                              saveContext: Bool)
    func removeCV(_ cv: UserCV,
                        context: NSManagedObjectContext,
                        saveContext: Bool) -> Bool
}

final class CVRepository {
    func fetchAllCVs(for template: Template, context: NSManagedObjectContext) -> [UserCV] {
        return fetchAllCVsFromDB(for: template, context: context).map({ $0.convertToDTO() })
    }
    
    private func fetchAllCVsFromDB(for template: Template, context: NSManagedObjectContext) -> [CVEntity] {
        return CVEntity.fetchAll(for: template, context: context)
    }
    
    func saveCV(_ cv: UserCV,
                context: NSManagedObjectContext,
                saveContext: Bool = true) {
        let _ = cv.convertToCoreDataEntity(context: context)
        guard saveContext else {
            return
        }
        do {
            try context.saveIfNeeded()
        } catch {
            print("Save failed")
        }
    }
    
    func removeCV(_ cv: UserCV,
                              context: NSManagedObjectContext) -> Bool {
        guard let id = cv.id else {
            return false
        }
        guard CVEntity.deleteEntityWithId(of: id, context: context) else {
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

