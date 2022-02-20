//
//  ContentView.swift
//  iFriends
//
//  Created by jescobar on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.list) { user in
                NavigationLink(destination: UserDetailsView(user: user)) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .onAppear {
                Task {
                    await viewModel.load()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
