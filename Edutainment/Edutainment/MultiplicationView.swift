//
//  MultiplicationView.swift
//  Edutainment
//
//  Created by jescobar on 12/14/21.
//

import SwiftUI

struct MultiplicationView: View {
    let table: Int
    let intents: Int
    @State private var intentsLeft = 0
    @State private var tables = Array(1...12).shuffled()
    @State private var showReset = false
    @State private var correctAnswer = 0
    private var times: Int {
        tables[correctAnswer]
    }
    @State private var points = 0

    var body: some View {
        Form {
            Section("What is \(table) times \(times)") {
                ForEach(0..<3) { number in
                    Button {
                        selectAnswer(with: number)
                    } label: {
                        Text("\(tables[number] * table)")
                    }
                }
            }
        }
        .navigationTitle("Table of \(table)")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Nice!", isPresented: $showReset) {
            Button(action: reset) {
                Text("Reset")
            }
        } message: {
            Text("You made \(points) points")
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    Text("\(points) points")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Intents: \(intentsLeft)")
            }
        }
        .onAppear {
            reset()
        }
    }

    private func reset() {
        shuffle()
        intentsLeft = intents
        points = 0
    }

    private func shuffle() {
        correctAnswer = Int.random(in: 0...2)
        tables = Array(1...12).shuffled()
    }

    private func selectAnswer(with number: Int) {
        intentsLeft -= 1
        if number == correctAnswer {
            points += 10
        } else {
            points -= 5
        }
        if intentsLeft > 0 {
            shuffle()
        } else {
            showReset = true
        }
    }
}

struct MultiplicationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MultiplicationView(table: 3, intents: 5)
        }
    }
}
