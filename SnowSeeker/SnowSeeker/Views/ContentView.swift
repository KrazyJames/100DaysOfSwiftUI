//
//  ContentView.swift
//  SnowSeeker
//
//  Created by jescobar on 3/15/22.
//

import SwiftUI

struct ContentView: View {
    @State private var resorts: [Resort] = Resort.allResorts
    @State private var searchText = ""
    @State private var presentDialog = false
    @StateObject private var favorites = Favorites()

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    ResortCellView(
                        resort: resort,
                        isFavorite: favorites.contains(resort)
                    )
                }
            }
            .navigationBarTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        presentDialog.toggle()
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .confirmationDialog("Select sorting", isPresented: $presentDialog) {
                ForEach(Resort.Sort.allCases) { sort in
                    Button {
                        resorts = Resort.sortedResorts(by: sort)
                    } label: {
                        Text(sort.rawValue)
                    }
                }
            }
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .previewDevice("iPad Air (4th generation)")
        }
    }
}
