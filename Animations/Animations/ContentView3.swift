//
//  ContentView3.swift
//  Animations
//
//  Created by jescobar on 12/7/21.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: .zero, anchor: .topLeading)
        )
    }
}

struct ContentView3: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
//            Button("Tap Me") {
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//            }
//
//            Rectangle()
//                .fill(.red)
//                .frame(width: isShowingRed ? 200 : .zero, height: isShowingRed ? 200 : .zero)
//                .transition(.scale)

            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)

                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
        }
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}
