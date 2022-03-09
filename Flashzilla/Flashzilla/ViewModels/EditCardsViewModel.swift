//
//  EditCardsViewModel.swift
//  Flashzilla
//
//  Created by jescobar on 3/9/22.
//

import Foundation

class EditCardsViewModel: ObservableObject {
    @Published private var list = [Card]()
    @Published var prompt = ""
    @Published var answer = ""

    var cards: [CardViewModel] {
        list.map(CardViewModel.init)
    }
    var isSaveDisabled: Bool {
        prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        answer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    init() {
        loadData()
    }

    private func loadData() {
        let result: Result<[Card], FileManagerError> = FileManager.default.decode("cards")
        switch result {
        case let .success(cards):
            self.list = cards
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

    private func saveData() {
        let result = FileManager.default.encode("cards", list)
        switch result {
        case let .failure(error):
            print(error.localizedDescription)
        case .success:
            print("Saved")
        }
    }

    func save() {
        let card = Card(prompt: prompt, answer: answer)
        list.insert(card, at: .zero)
        saveData()
        prompt = ""
        answer = ""
    }

    func delete(at offsets: IndexSet) {
        list.remove(atOffsets: offsets)
        saveData()
    }
}
