//
//  MissionViewModel.swift
//  Moonshot
//
//  Created by jescobar on 1/12/22.
//

import Foundation

struct MissionViewModel: Identifiable {
    let mission: Mission
    let crew: [CrewMemberViewModel]

    var id: Int {
        mission.id
    }

    var displayName: String {
        "Apollo \(mission.id)"
    }

    var image: String {
        "apollo\(mission.id)"
    }

    var fullDate: String {
        mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "None"
    }

    var date: String {
        mission.launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }

    var highlights: String {
        mission.description
    }
}

class MissionsViewModel: ObservableObject {
    @Published var missions = [MissionViewModel]()

    init() {
        let missions: [Mission] = Bundle.main.decode("missions.json")
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        self.missions = missions.map({ mission in
            let crew: [CrewMemberViewModel] = mission.crew.compactMap { crewRole in
                .init(member: .init(role: crewRole.role, astronaut: astronauts[crewRole.name]))
            }
            return MissionViewModel(mission: mission, crew: crew)
        })
    }
}
