//
//  UserDetailsView.swift
//  iFriends
//
//  Created by jescobar on 2/3/22.
//

import SwiftUI

struct UserDetailsView: View {
    let user: UserViewModel
    var body: some View {
        List {
            Section("Personal info") {
                Text(user.age)
                Text(user.registered)
                Text(user.company)
            }
            Section("Contact info") {
                Text(user.email)
                Text(user.address)
            }
            Section("About") {
                Text(user.bio)
            }
            Section("Tags") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .tagView(.accentColor)
                        }
                    }
                    .padding()
                }
                .listRowInsets(EdgeInsets())
            }
            Section("Friends") {
                NavigationLink(destination: FriendListView(friends: user.friends)) {
                    Text("Friends: \(user.friends.count)")
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailsView(user: .demo)
        }
    }
}
