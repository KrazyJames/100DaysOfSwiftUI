//
//  CrewMemberViewModel.swift
//  Moonshot
//
//  Created by jescobar on 1/13/22.
//

import Foundation

struct CrewMemberViewModel: Identifiable {
    let member: CrewMember

    var id: String {
        member.astronaut.id
    }

    var name: String {
        member.astronaut.name
    }

    var role: String {
        member.role
    }

    var description: String {
        member.astronaut.description
    }

    var astronaut: AstronautViewModel {
        .init(astronaut: member.astronaut)
    }
}

extension CrewMemberViewModel {
    init?(member: CrewMember?) {
        guard let member = member else {
            return nil
        }
        self.member = member
    }
}

struct AstronautViewModel: Identifiable {
    let astronaut: Astronaut

    var id: String {
        astronaut.id
    }

    var name: String {
        astronaut.name
    }

    var description: String {
        astronaut.description
    }
}
