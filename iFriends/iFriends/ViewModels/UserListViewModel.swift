//
//  UserListViewModel.swift
//  iFriends
//
//  Created by jescobar on 2/3/22.
//

import Foundation
import SwiftUI
import CoreData

final class UserListViewModel: ObservableObject {
    @Published var list: [UserViewModel] = []
    private let moc = DataController().container.viewContext

    func load() async {
        if list.isEmpty {
            loadFromDB()
            if list.isEmpty {
                await loadFromAPI()
            }
        }
    }

    func loadFromAPI() async {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let users: [User] = try? await API.load(url: API.url, decoder) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.list = users.map(UserViewModel.init)
            self?.save(users)
        }
    }

    func loadFromDB() {
        let request: NSFetchRequest<CachedUser> = CachedUser.fetchRequest()
        guard let cachedUsers = try? moc.fetch(request) else { return }
        list = cachedUsers.map(UserViewModel.init)
    }

    func save(_ users: [User]) {
        users.forEach { user in
            user.friends.forEach { friend in
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                cachedFriend.user = CachedUser(context: moc)
                cachedFriend.user?.id = user.id
                cachedFriend.user?.isActive = user.isActive
                cachedFriend.user?.name = user.name
                cachedFriend.user?.age = Int16(user.age)
                cachedFriend.user?.company = user.company
                cachedFriend.user?.email = user.email
                cachedFriend.user?.address = user.address
                cachedFriend.user?.bio = user.about
                cachedFriend.user?.registered = user.registered
                cachedFriend.user?.tags = user.tags.joined(separator: ",")
                if moc.hasChanges {
                    try? moc.save()
                }
            }
        }
    }
}

struct UserViewModel: Identifiable {
    let user: User

    var id: UUID {
        user.id
    }
    var isActive: Bool {
        user.isActive
    }
    var name: String {
        user.name
    }
    var age: String {
        String(user.age)
    }
    var company: String {
        user.company
    }
    var email: String {
        user.email
    }
    var address: String {
        user.address
    }
    var bio: String {
        user.about
    }
    var registered: String {
        user.registered.formatted(date: .abbreviated, time: .shortened)
    }
    var tags: [String] {
        user.tags
    }
    var friends: [FriendViewModel] {
        user.friends.map(FriendViewModel.init)
    }
}

extension UserViewModel {
    init(_ cachedUser: CachedUser) {
        self.init(user: .init(cachedUser))
    }

    static let demo = UserViewModel(user: .demo)
}

struct FriendViewModel: Identifiable {
    let friend: Friend

    var id: UUID {
        friend.id
    }

    var name: String {
        friend.name
    }
}

extension FriendViewModel {
    static let demo = FriendViewModel(friend: .demo)
}
