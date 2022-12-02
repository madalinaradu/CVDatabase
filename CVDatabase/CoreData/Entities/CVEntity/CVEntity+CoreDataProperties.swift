//
//  CVEntity+CoreDataProperties.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//
//

import Foundation
import CoreData


extension CVEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CVEntity> {
        return NSFetchRequest<CVEntity>(entityName: "CVEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var age: Int16
    @NSManaged public var studies: String?
    @NSManaged public var experience: String?
    @NSManaged public var skills: String?
    @NSManaged public var personalProjects: String?
    @NSManaged public var template: TemplateEntity?

}

extension CVEntity : Identifiable {

}
