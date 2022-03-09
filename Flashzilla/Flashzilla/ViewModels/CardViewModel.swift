//
//  CardViewModel.swift
//  Flashzilla
//
//  Created by jescobar on 3/9/22.
//

import Foundation
import SwiftUI

class CardsViewModel: ObservableObject {
    @Published private(set) var cards: [CardViewModel] = []
    @Published var timeRemaining = 100
    @Published var isActive = true
    @Published var showEdit = false
    var hasTimeRemaining: Bool {
        timeRemaining > .zero
    }
    var count: Int {
        cards.count
    }
    var isEmpty: Bool {
        cards.isEmpty
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func reset() {
        loadData()
        isActive = !cards.isEmpty
        timeRemaining = 100
    }

    func timerUpdated() {
        guard isActive else { return }
        if hasTimeRemaining {
            timeRemaining -= 1
        }
    }

    func sceneUpdated(_ newValue: ScenePhase) {
        if newValue == .active,
           !cards.isEmpty {
            isActive = true
        } else {
            isActive = false
        }
    }

    func isLast(_ card: CardViewModel) -> Bool {
        cards.isLast(card)
    }

    func firstIndex(of card: CardViewModel) -> Int {
        cards.firstIndex(of: card) ?? .zero
    }

    private func loadData() {
        let result: Result<[Card], FileManagerError> = FileManager.default.decode("cards")
        switch result {
        case let .success(cards):
            self.cards = cards.map(CardViewModel.init)
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

    func removeCard(isCorrect: Bool) {
        let card = cards.removeLast()
        if !isCorrect {
            // This makes a new card with new UUID and the list will interpretate this as a completely new item and will render itself again
            cards.insert(
                .init(
                    card: Card(
                        prompt: card.prompt,
                        answer: card.answer
                    )
                ),
                at: .zero
            )
        }
        if cards.isEmpty { isActive = false }
    }
}

struct CardViewModel: Identifiable, Equatable {
    let card: Card

    var id: UUID {
        card.id
    }

    var prompt: String {
        card.prompt
    }

    var answer: String {
        card.answer
    }
}

extension CardViewModel {
    static let demo = Self.init(card: .demo)
}
