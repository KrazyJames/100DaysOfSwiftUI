//
//  CardView.swift
//  Flashzilla
//
//  Created by jescobar on 3/5/22.
//

import SwiftUI

struct CardView: View {
    let card: CardViewModel
    var remove: ((Bool) -> Void)? = nil

    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var showAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    private var cardColor: Color {
        offset.width >= 0 ? offset.width == 0 ? Color.white : Color.green : Color.red
    }

    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 25,
                style: .continuous
            )
            .fill(
                accessibilityDifferentiateWithoutColor
                ? .white
                : .white
                    .opacity(
                        1 - Double(
                            abs(
                                offset.width / 50
                            )
                        )
                    )
            )
            .background(
                accessibilityDifferentiateWithoutColor
                ? nil
                : RoundedRectangle(
                    cornerRadius: 25,
                    style: .continuous
                )
                .fill(cardColor)
            )
            .shadow(radius: 10)
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(showAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if showAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: .zero)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = value.translation
                    feedback.prepare()
                }
                .onEnded { value in
                    if abs(offset.width) > 100 {
                        if offset.width < 0 {
                            feedback.notificationOccurred(.error)
                        }
                        self.remove?(offset.width > 0)
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            showAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .demo)
            .padding()
            .previewLayout(.sizeThatFits)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
