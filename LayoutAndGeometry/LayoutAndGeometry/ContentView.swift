//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by jescobar on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(1..<50) { index in
                    GeometryReader { geo in
                        Text("Row \(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: min((geo.frame(in: .global).minY) / (fullView.size.height), 1.0), saturation: 1, brightness: (geo.frame(in: .global).minY) / (fullView.size.height / 2)))
                            .scaleEffect(min(0.5 + (geo.frame(in: .global).minY) / (fullView.size.height / 2), 1.5))
                            .opacity((geo.frame(in: .global).minY) / (fullView.size.height / 2))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .onTapGesture {
                                print((geo.frame(in: .global).minY) / (fullView.size.height / 2))

                            }
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
