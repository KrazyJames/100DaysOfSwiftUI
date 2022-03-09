//
//  EditCards.swift
//  Flashzilla
//
//  Created by jescobar on 3/8/22.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = EditCardsViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section("Add new card") {
                    TextField("Prompt", text: $viewModel.prompt)
                    TextField("Answer", text: $viewModel.answer)
                    HStack {
                        Spacer()
                        Button("Save", action: viewModel.save)
                            .disabled(viewModel.isSaveDisabled)
                        Spacer()
                    }
                }

                Section("Cards") {
                    ForEach(viewModel.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: viewModel.delete)
                }
            }
            .navigationTitle("Edit cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done", action: done)
            }
        }
    }

    private func done() {
        dismiss()
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
