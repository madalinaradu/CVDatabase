//
//  NSManagedObjectModel+sharedModel.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import CoreData

extension NSManagedObjectModel {
    /// We use this static shared model to prevent errors like:
    /// `Failed to find a unique match for an NSEntityDescription to a managed object subclass`
    ///
    /// This error likely occurs when running tests with an in-memory store while the regular app launch loads a file backed store.
    
    static let sharedModel: NSManagedObjectModel = {
        let url = Bundle(for: CoreDataContainer.self).url(forResource: "CVDatabase", withExtension: "momd")!
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Managed object model could not be created.")
        }
        return managedObjectModel
    }()
    
}
