//
//  ContentView.swift
//  Drawing
//
//  Created by jescobar on 1/17/22.
//

import SwiftUI

struct Arrow: Shape {
    var innerValue: Double

    var animatableData: Double {
        get { innerValue }
        set { innerValue = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addLines([
            CGPoint(x: rect.midX, y: rect.minY),
            CGPoint(x: rect.minX, y: rect.maxY),
            CGPoint(x: rect.midX, y: rect.midY + innerValue),
            CGPoint(x: rect.maxX, y: rect.maxY),
            CGPoint(x: rect.midX, y: rect.minY)
        ])
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var startPoint = 0.5
    var endPoint = 0.5

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: startPoint, y: .zero),
                            endPoint: UnitPoint(x: endPoint, y: 1)
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var innerValue: Double = .zero

    @State private var colorCycle: Double = .zero
    @State private var startPoint: Double = 0.5
    @State private var endPoint: Double = 0.5

    let maxArrowHeight = 200.0
    var body: some View {
        VStack {
            Spacer()
            Arrow(innerValue: innerValue)
                .stroke(.red,
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin: .round
                        )
                )
                .frame(width: maxArrowHeight, height: maxArrowHeight)
                .animation(
                    .easeInOut(duration: 2)
                        .repeatForever(autoreverses: true),
                    value: innerValue
                )
            Spacer()
            VStack {
                ColorCyclingRectangle(amount: colorCycle, startPoint: startPoint, endPoint: endPoint)
                    .frame(width: 200, height: 200)
                Group {
                    Text("Color cycle")
                    Slider(value: $colorCycle)
                    Text("Start Point")
                    Slider(value: $startPoint)
                    Text("End Point")
                    Slider(value: $endPoint)
                }
            }
        }
        .padding()
        .onAppear {
            innerValue = maxArrowHeight/2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
