//
//  MissionView.swift
//  Moonshot
//
//  Created by jescobar on 1/13/22.
//

import SwiftUI

struct MissionView: View {
    let mission: MissionViewModel
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    VStack(spacing: 20) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geo.size.width * 0.6)

                        Text(mission.fullDate)
                            .font(.subheadline)
                    }
                    .padding()

                    Divider()
                    VStack(alignment: .leading) {
                        Text("Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.highlights)
                    }
                    .padding()

                    Divider()
                    VStack(alignment: .leading) {
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.horizontal)
                        CrewMembersView(crew: mission.crew)
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MissionView(
                mission: MissionViewModel(
                    mission: .testMission,
                    crew: [
                        CrewMemberViewModel(
                            member: .testMember
                        )
                    ]
                )
            )
        }
        .preferredColorScheme(.dark)
    }
}
