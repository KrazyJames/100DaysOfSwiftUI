//
//  CrewMembersView.swift
//  Moonshot
//
//  Created by jescobar on 1/13/22.
//

import SwiftUI

struct CrewMembersView: View {
    let crew: [CrewMemberViewModel]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        CrewMemberTagView(member: crewMember)
                        .padding(.horizontal)
                    }

                }
            }
        }
    }
}

struct CrewMemberTagView: View {
    let member: CrewMemberViewModel
    var body: some View {
        HStack {
            Image(decorative: member.id)
                .resizable()
                .scaledToFill()
                .frame(
                    width: 72,
                    height: 72
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .strokeBorder(
                            .white,
                            lineWidth: 1
                        )
                )
            VStack(alignment: .leading) {
                Text(member.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(member.role)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Member role: \(member.role)")
            }
            .accessibilityElement(children: .combine)
        }
    }
}

struct CrewMembersView_Previews: PreviewProvider {
    static var previews: some View {
        CrewMembersView(
            crew: [
                CrewMemberViewModel(
                    member: .testMember
                )
            ]
        )
        .padding(.vertical)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
        .background(.darkBackground)
    }
}
