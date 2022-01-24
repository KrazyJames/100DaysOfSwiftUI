//
//  HabitListView.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import SwiftUI

struct HabitListView: View {
    @StateObject var viewModel = HabitListViewModel()

    var body: some View {
        List {
            ForEach(viewModel.list) { habit in
                NavigationLink(
                    destination: HabitDetailsView(
                        viewModel: habit
                    )
                ) {
                    VStack(alignment: .leading) {
                        Text(habit.name)
                            .font(.headline)
                        Text(habit.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onMove(perform: viewModel.move)
            .onDelete(perform: viewModel.remove)
        }
        .navigationTitle("Habits")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
                    .disabled(viewModel.isEmpty)
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    viewModel.presentAddView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $viewModel.isAddViewPresented) {
            AddHabitView(
                viewModel: AddHabitViewModel(viewModel)
            )
        }
    }
}

struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HabitListView(
                viewModel: .demo
            )
        }
    }
}
