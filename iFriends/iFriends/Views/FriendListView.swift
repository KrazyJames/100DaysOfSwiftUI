//
//  FriendListView.swift
//  iFriends
//
//  Created by jescobar on 2/3/22.
//

import SwiftUI

struct FriendListView: View {
    let friends: [FriendViewModel]
    var body: some View {
        List(friends) { friend in
            Text(friend.name)
        }
        .navigationTitle("Friends")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FriendListView(friends: [.demo, .demo])
        }
    }
}
