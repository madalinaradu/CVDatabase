//
//  TemplateEntity+CoreDataProperties.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//
//

import Foundation
import CoreData


extension TemplateEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TemplateEntity> {
        return NSFetchRequest<TemplateEntity>(entityName: "TemplateEntity")
    }

    @NSManaged public var hasName: Bool
    @NSManaged public var hasPhone: Bool
    @NSManaged public var hasEmail: Bool
    @NSManaged public var hasAge: Bool
    @NSManaged public var hasStudies: Bool
    @NSManaged public var hasExperience: Bool
    @NSManaged public var hasSkills: Bool
    @NSManaged public var hasPersonalProjects: Bool
    @NSManaged public var cvs: NSSet?

}

// MARK: Generated accessors for cvs
extension TemplateEntity {

    @objc(addCvsObject:)
    @NSManaged public func addToCvs(_ value: CVEntity)

    @objc(removeCvsObject:)
    @NSManaged public func removeFromCvs(_ value: CVEntity)

    @objc(addCvs:)
    @NSManaged public func addToCvs(_ values: NSSet)

    @objc(removeCvs:)
    @NSManaged public func removeFromCvs(_ values: NSSet)

}

extension TemplateEntity : Identifiable {

}
