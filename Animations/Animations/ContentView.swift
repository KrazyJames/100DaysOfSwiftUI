//
//  ContentView.swift
//  Animations
//
//  Created by jescobar on 12/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var scale = 1.0
    @State private var bouncing = 1.0
    @State private var step = 1.0
    @State private var rotation = 0.0
    var body: some View {
        VStack {
            // Implicit animation
            Button("Tap") {
                bouncing += 1
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(bouncing)
            .blur(radius: (bouncing - 1) * 2)
            .animation(
                .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                value: bouncing
            )
            .frame(maxHeight: .infinity)
            Button("Tap") {
                bouncing = 1.0
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(scale)
                    .opacity((2 - scale))
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: scale
                    )
            )
            .frame(maxHeight: .infinity)
            VStack {
                // Binding animation
                Stepper("Step", value: $step.animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true)), in: 1...10)
                    .padding()
                Button("Step") {
                    step = 1.0
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(step)
            }
            .frame(maxHeight: .infinity)
            Button("Rotate") {
                // Explicit animation
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                    rotation += 360
                }
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(rotation),
                axis: (x: .zero, y: 1.0, z: .zero)
            )
        }
        .onAppear {
            scale = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
