//
//  Mission.swift
//  Moonshot
//
//  Created by jescobar on 1/12/22.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}

extension Mission {
    static var testMission: Mission {
        Mission(
            id: 1,
            launchDate: Date(),
            crew: [Mission.CrewRole(name: "armstrong", role: "Some")],
            description: "Description of the mission"
        )
    }
}
