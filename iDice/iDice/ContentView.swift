//
//  ContentView.swift
//  iDice
//
//  Created by jescobar on 3/14/22.
//

import SwiftUI

struct HistoryModel: Codable, Identifiable {
    var id = UUID()
    let diceType: DiceType
    let value: Int
}

class ContentViewModel: ObservableObject {
    @Published var history = [HistoryModel]()
    @Published var dice = DiceType.sixSided
    @Published var diceValue: Int = 1
    @Published var shouldShowHistory = false
    @Published var shouldShowDiceTypeSelector = false
    @Published var flip: Double = .zero

    init() {
        let result: Result<[HistoryModel], FileManagerError> = FileManager.default.decode("iDiceHistory")
        switch result {
        case let .success(history):
            self.history = history
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

    func showHistory() {
        shouldShowHistory = true
    }

    func selectDiceType() {
        shouldShowDiceTypeSelector = true
    }

    func rollDice() {
        flip = .zero
        let newValue = Int.random(in: 1...dice.rawValue)
        if newValue != diceValue {
            history.append(.init(diceType: dice, value: newValue))
            save()
            withAnimation {
                flip += 360
                diceValue = newValue
            }
        } else {
            rollDice()
        }
    }

    func save() {
        let result = FileManager.default.encode("iDiceHistory", history)
        switch result {
        case .success:
            print("Saved")
        case let .failure(error):
            print(error.localizedDescription)
        }
    }
}

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("\(viewModel.diceValue)")
                    .font(.largeTitle)
                    .rotation3DEffect(.degrees(viewModel.flip), axis: (1,1,1))
                    .accessibilityLabel("Dice value")
                    .accessibilityHint("\(viewModel.diceValue)")
                Spacer()
                Button(action: viewModel.rollDice) {
                    Text("Roll dice")
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("iDice")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: viewModel.showHistory) {
                        Label("Show history", systemImage: "clock.fill")
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Button(action: viewModel.selectDiceType) {
                        Label("Select dice type", systemImage: "dice.fill")
                    }
                }
            }
            .sheet(isPresented: $viewModel.shouldShowHistory) {
                HistoryView(history: $viewModel.history)
            }
            .confirmationDialog("Select dice type", isPresented: $viewModel.shouldShowDiceTypeSelector) {
                ForEach(DiceType.allCases) { type in
                    Button(type.stringValue) {
                        viewModel.dice = type
                    }
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
