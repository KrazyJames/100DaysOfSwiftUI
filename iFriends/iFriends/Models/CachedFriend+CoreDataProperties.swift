//
//  CachedFriend+CoreDataProperties.swift
//  iFriends
//
//  Created by jescobar on 2/4/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    public var unwrappedName: String {
        name ?? ""
    }

}

extension CachedFriend : Identifiable {

}

extension CachedFriend: Comparable {
    public static func < (lhs: CachedFriend, rhs: CachedFriend) -> Bool {
        lhs.unwrappedName < rhs.unwrappedName
    }
}
