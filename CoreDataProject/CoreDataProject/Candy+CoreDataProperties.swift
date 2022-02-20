//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by jescobar on 2/1/22.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown"
    }

}

extension Candy : Identifiable {

}

extension Candy: Comparable {
    public static func < (lhs: Candy, rhs: Candy) -> Bool {
        lhs.wrappedName < rhs.wrappedName
    }
}
