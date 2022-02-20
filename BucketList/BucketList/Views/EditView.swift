//
//  EditView.swift
//  BucketList
//
//  Created by jescobar on 2/15/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel: ViewModel
    var onSave: (Location) -> Void

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextEditor(text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(viewModel.pages, id:\.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(viewModel.newLocation)
                    dismiss()
                }
            }
            .task { await viewModel.fetchNearby() }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: .demo, onSave: { _ in })
    }
}
