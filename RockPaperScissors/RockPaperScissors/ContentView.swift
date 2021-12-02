//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by jescobar on 11/29/21.
//

import SwiftUI

enum SelectionType: String, CaseIterable, Identifiable, Comparable {
    var id: Self {
        self
    }

    case rock, paper, scissors

    var systemImage: String {
        switch self {
        case .rock:
            return "cloud.fill"
        case .paper:
            return "newspaper.fill"
        case .scissors:
            return "scissors"
        }
    }

    static func < (lhs: SelectionType, rhs: SelectionType) -> Bool {
        switch lhs {
        case .rock:
            switch rhs {
            case .rock:
                return false
            case .paper:
                return true
            case .scissors:
                return false
            }
        case .paper:
            switch rhs {
            case .rock:
                return false
            case .paper:
                return false
            case .scissors:
                return true
            }
        case .scissors:
            switch rhs {
            case .rock:
                return true
            case .paper:
                return false
            case .scissors:
                return false
            }
        }
    }
}

struct ContentView: View {
    @State private var machineSelection: SelectionType =
    SelectionType.allCases[
        Int.random(
            in: 0..<SelectionType.allCases.count
        )
    ]
    @State private var shouldWin: Bool = Bool.random()
    @State private var wins: Int = .zero
    @State private var score: Int = .zero
    @State private var tries: Int = 10
    @State private var presentAlert: Bool = false
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack(spacing: 10) {
                Text("Machine selection")
                    .font(.title3)
                Label(machineSelection.rawValue.capitalized, systemImage: machineSelection.systemImage)
                    .font(.title)
            }
            Spacer()
            VStack {
                Text("You should")
                    .font(.title3)
                Text("\(shouldWin ? "Win" : "Lose")")
                    .font(.title)
                    .foregroundColor(shouldWin ? .green : .red)
            }
            Spacer()
            HStack(spacing: 20) {
                ForEach(SelectionType.allCases) { selectionType in
                    if selectionType != machineSelection {
                        GameButton(selectionType: selectionType, action: { play(with: selectionType) })
                    }
                }
            }
            Spacer()
            Spacer()
            Text("Score: \(score)")
            Spacer()
        }
        .padding()
        .alert("This is the summary", isPresented: $presentAlert) {
            Button("Restart", action: restart)
        } message: {
            Text("You win \(wins) times with \(score) points")
        }
    }

    private func play(with userSelection: SelectionType) {
        tries -= 1
        if tries > .zero {
            if (shouldWin && userSelection > machineSelection) || (!shouldWin && userSelection < machineSelection) {
                score += 1
                wins += 1
            } else {
                score -= 1
            }
            reset()
        } else {
            presentAlert.toggle()
        }
    }

    private func reset() {
        machineSelection = SelectionType.allCases[
            Int.random(
                in: .zero..<SelectionType.allCases.count
            )
        ]
        shouldWin = Bool.random()
    }

    private func restart() {
        reset()
        score = .zero
        wins = .zero
        tries = 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameButton: View {
    let selectionType: SelectionType
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: selectionType.systemImage)
                    .font(.largeTitle)
                Text(selectionType.rawValue.capitalized)
                    .font(.title2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
        .buttonStyle(.bordered)
        .tint(.primary)
    }
}
