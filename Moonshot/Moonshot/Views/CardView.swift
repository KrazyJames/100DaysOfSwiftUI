//
//  CardView.swift
//  Moonshot
//
//  Created by jescobar on 1/12/22.
//

import SwiftUI

struct CardView: View {
    let mission: MissionViewModel
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(mission.date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(mission: MissionViewModel(mission: Mission(id: 1, launchDate: nil, crew: [], description: ""), crew: []))
            .padding()
            .previewLayout(.sizeThatFits)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
