//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by jescobar on 11/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingResult = false
    @State private var tries = 8
    @State private var correctOnes = 0
    @State private var wrongOnes = 0

    @State private var rotations = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var selectedItem = -1

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            ).ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Select the flag of")
                            .font(.title.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                        .rotation3DEffect(.degrees(rotations[number]), axis: (x: .zero, y: 1.0, z: .zero))
                        .scaleEffect(selectedItem == number ? 1.25 : 1.0)
                        .opacity(opacities[number])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("Final score: \(score)", isPresented: $showingResult) {
            Button("Reset", action: reset)
        } message: {
            VStack {
                Text("You got \(correctOnes) correct and \(wrongOnes) wrong")
            }
        }
    }

    func reset() {
        score = 0
        tries = 8
        correctOnes = 0
        wrongOnes = 0
        askQuestion()
    }

    func flagTapped(_ number: Int) {
        tries -= 1
        withAnimation {
            selectedItem = number
            rotations[number] += 360
        }
        for (index, _) in opacities.enumerated() {
            if index != number {
                opacities[index] = 0.5
            }
        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
            correctOnes += 1
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            score -= 10
            wrongOnes += 1
        }
        showingScore.toggle()
    }

    func askQuestion() {
        if tries > 0 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            showingResult.toggle()
        }
        withAnimation {
            selectedItem = -1
            opacities = [1, 1, 1]
            rotations = [0, 0, 0]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    let countryName: String
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(countryName: "US")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
