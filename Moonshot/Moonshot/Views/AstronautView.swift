//
//  AstronautView.swift
//  Moonshot
//
//  Created by jescobar on 1/13/22.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: AstronautViewModel

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding()
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AstronautView(
                astronaut: AstronautViewModel(
                    astronaut: .testAstronaut
                )
            )
        }
        .preferredColorScheme(.dark)
    }
}
