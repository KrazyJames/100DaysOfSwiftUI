//
//  ContentView.swift
//  Moonshot
//
//  Created by jescobar on 1/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MissionsViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State var isGrid = true

    var body: some View {
        NavigationView {
            contentView
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        isGrid.toggle()
                    } label: {
                        Image(systemName: isGrid ? "list.bullet" : "square.grid.2x2")
                    }
                    .tint(.primary)
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if isGrid {
            ScrollView {
                LazyVGrid(columns: columns) {
                    forEach(isGrid, missions: viewModel.missions)
                }
                .padding()
            }
        } else {
            List {
                forEach(isGrid, missions: viewModel.missions)
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
        }
    }

    @ViewBuilder
    private func forEach(_ isGrid: Bool, missions: [MissionViewModel]) -> some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission)
            } label: {
                itemView(isGrid, mission: mission)
            }
        }
    }

    @ViewBuilder
    private func itemView(_ isGrid: Bool, mission: MissionViewModel) -> some View {
        if isGrid {
            CardView(mission: mission)
        } else {
            RowView(mission: mission)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

