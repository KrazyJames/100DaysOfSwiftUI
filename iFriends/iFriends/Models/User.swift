//
//  User.swift
//  iFriends
//
//  Created by jescobar on 2/3/22.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

extension User {
    init(_ cachedUser: CachedUser) {
        self.id = cachedUser.id
        self.isActive = cachedUser.isActive
        self.name = cachedUser.unwrappedName
        self.age = cachedUser.unwrappedAge
        self.company = cachedUser.unwrappedCompany
        self.email = cachedUser.unwrappedEmail
        self.address = cachedUser.unwrappedAddress
        self.about = cachedUser.unwrappedBio
        self.registered = cachedUser.registeredDate
        self.tags = cachedUser.tagList
        self.friends = cachedUser.friendList
    }

    static let demo = User(id: .init(), isActive: false, name: "Username", age: 99, company: "Company name", email: "example@email.com", address: "Somewhere 123, XX, YY", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat.", registered: .init(), tags: ["Demo tag", "Demo tag", "Demo tag"], friends: [.demo, .demo])
}
