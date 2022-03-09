//
//  ContentView.swift
//  Flashzilla
//
//  Created by jescobar on 3/3/22.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase

    @StateObject private var viewModel = CardsViewModel()

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(viewModel.timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        .black
                            .opacity(0.75)
                    )
                    .clipShape(
                        Capsule()
                    )
                ZStack {
                    ForEach(viewModel.cards) { card in
                        CardView(
                            card: card
                        ) { correct in
                            withAnimation {
                                viewModel.removeCard(isCorrect: correct)
                            }
                        }
                        .stacked(
                            at: viewModel.firstIndex(of: card),
                            in: viewModel.count
                        )
                        .allowsHitTesting(viewModel.isLast(card))
                        .accessibilityHidden(!viewModel.isLast(card))
                    }
                }
                .allowsHitTesting(viewModel.hasTimeRemaining)
                if viewModel.isEmpty {
                    Button("Restart", action: viewModel.reset)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(
                            Capsule()
                        )
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        viewModel.showEdit = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(
                                Circle()
                            )
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            if accessibilityDifferentiateWithoutColor ||
                accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                viewModel.removeCard(isCorrect: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(
                                    .black
                                        .opacity(0.7)
                                )
                                .clipShape(
                                    Circle()
                                )
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as incorrect")

                        Spacer()

                        Button {
                            withAnimation {
                                viewModel.removeCard(isCorrect: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(
                                    .black
                                        .opacity(0.7)
                                )
                                .clipShape(
                                    Circle()
                                )
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as correct")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(viewModel.timer) { _ in
            viewModel.timerUpdated()
        }
        .onChange(
            of: scenePhase,
            perform: viewModel.sceneUpdated
        )
        .onAppear(
            perform: viewModel.reset
        )
        .sheet(
            isPresented: $viewModel.showEdit,
            onDismiss: viewModel.reset,
            content: EditCards.init
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
