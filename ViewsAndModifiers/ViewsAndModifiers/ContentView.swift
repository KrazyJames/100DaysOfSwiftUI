//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by jescobar on 11/27/21.
//

import SwiftUI

struct FancyTitle: ViewModifier {
    var colors: [Color]
    var startPoint: UnitPoint
    var endPoint: UnitPoint

    func body(content: Content) -> some View {
        LinearGradient(
            colors: colors,
            startPoint: startPoint,
            endPoint: endPoint
        ).mask(
            content.font(.largeTitle.bold())
        )
    }
}

extension View {
    func fancyTitle(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        modifier(
            FancyTitle(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
    }
}

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func largeBlueTitle() -> some View {
        modifier(LargeBlueTitle())
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    @State private var useRedText = false
    @ViewBuilder var houses: some View {
        Group {
            Text("Gryffindor")
//                .modifier(Title())
                .titleStyle()
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
                .largeBlueTitle()
        }
        .font(.title)
    }
    var body: some View {
        VStack {
            Button("Hello, world!") {
                useRedText.toggle()
                print(type(of: self.body))
            }
            .foregroundColor(useRedText ? .red : .blue)
            .background(.red)
            .frame(width: 150, height: 100)

            Button("Hello, world!") {
                useRedText.toggle()
                print(type(of: self.body))
            }
            .foregroundColor(useRedText ? .red : .blue)
            .frame(width: 150, height: 100)
            .background(.red)
            .watermarked(with: "KrazyJames")

            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
            HStack {
                Image(systemName: "arrow.left")
                VStack(alignment: .leading) {
                    Text("FancyTitle")
                    Text("ViewModifier")
                }
                Image(systemName: "arrow.right")
            }
            .fancyTitle(
                colors: [.red, .blue, .black],
                startPoint: .leading,
                endPoint: .trailing
            )
            .padding()
            CapsuleText(text: "Capsule")
                .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
