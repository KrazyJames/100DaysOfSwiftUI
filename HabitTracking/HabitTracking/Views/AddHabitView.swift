//
//  AddHabitView.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var viewModel: AddHabitViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Name:")
                    Spacer()
                    TextField("Name", text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Description:")
                    Spacer()
                    TextField("Description", text: $viewModel.description)
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle("New habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.addHabit()
                    } label: {
                        Text("Add")
                    }
                    .disabled(viewModel.isDisabled)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .onChange(of: viewModel.shouldDismiss) { shouldDismiss in
                if shouldDismiss {
                    dismiss()
                }
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(
            viewModel: AddHabitViewModel(.demo)
        )
    }
}
