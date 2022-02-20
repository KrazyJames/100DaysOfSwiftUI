//
//  CachedUser+CoreDataProperties.swift
//  iFriends
//
//  Created by jescobar on 2/4/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var bio: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var unwrappedName: String {
        name ?? ""
    }

    public var unwrappedIsActive: Bool {
        isActive
    }

    public var unwrappedAge: Int {
        Int(age)
    }

    public var unwrappedCompany: String {
        company ?? "N/A"
    }

    public var unwrappedEmail: String {
        email ?? "N/A"
    }

    public var unwrappedAddress: String {
        address ?? "N/A"
    }

    public var unwrappedBio: String {
        bio ?? ""
    }

    public var registeredDate: Date {
        registered ?? .now
    }

    public var tagList: [String] {
        tags?.components(separatedBy: ",") ?? []
    }

    public var friendList: [Friend] {
        guard let set = friends as? Set<CachedFriend> else { return [] }
        return set.sorted { $0 < $1 }.compactMap(Friend.init)
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
