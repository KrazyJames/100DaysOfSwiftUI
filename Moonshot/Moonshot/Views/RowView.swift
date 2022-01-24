//
//  RowView.swift
//  Moonshot
//
//  Created by jescobar on 1/14/22.
//

import SwiftUI

struct RowView: View {
    let mission: MissionViewModel
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 75)

            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                Text(mission.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(
            mission: MissionViewModel(
                mission: .testMission,
                crew: [
                    CrewMemberViewModel(
                        member: .testMember
                    )
                ]
            )
        )
        .padding()
        .background(.darkBackground)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
