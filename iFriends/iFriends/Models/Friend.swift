//
//  Friend.swift
//  iFriends
//
//  Created by jescobar on 2/4/22.
//

import Foundation

public struct Friend: Identifiable, Decodable {
    public let id: UUID
    let name: String
}

extension Friend {
    init(_ cachedFriend: CachedFriend) {
        self.id = cachedFriend.id
        self.name = cachedFriend.unwrappedName
    }

    static let demo = Friend(id: .init(), name: "Demo friend name")
}
