//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by jescobar on 2/19/22.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]

    @State private var selectedPic = Int.random(in: 0...3)
    @State private var value = 10

    var body: some View {
        VStack(spacing: 50) {
            Image(pictures[selectedPic])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedPic = Int.random(in: 0...3)
                }
                .accessibilityLabel(labels[selectedPic]) // This will add a custom text to read when te user taps on the element
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage) // Adding or removing traits will help the user to understand what kind of element they are tapping on

            VStack {
                Text("Your score is")
                Text("1000").font(.title)
            }
            .accessibilityElement(children: .combine) // This will combine the texts and read them togheter

            VStack {
                Text("Value: \(value)")
                Button("Increment") {
                    value += 1
                }
                Button("Decrement") {
                    value -= 1
                }
            }
            .accessibilityElement()
            .accessibilityLabel("Value")
            .accessibilityValue(String(value)) // It will read out the current value before it reads the label
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value += 1
                case .decrement:
                    value -= 1
                @unknown default:
                    print("Not handled")
                }
            } // This will act as an slider (vertically) to increment or decrement the value using swipe up or down gestures, making the UX better
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
