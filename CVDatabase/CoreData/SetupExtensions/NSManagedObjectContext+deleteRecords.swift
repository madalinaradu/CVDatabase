//
//  NSManagedObjectContext+deleteRecords.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import CoreData

extension NSManagedObjectContext {
    func deleteRecords(for entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try CoreDataContainer.shared.persistentStoreCoordinator.execute(deleteRequest, with: self)
        } catch let error as NSError {
            print("Deletion failed: \(error.localizedDescription)")
        }
    }
}
