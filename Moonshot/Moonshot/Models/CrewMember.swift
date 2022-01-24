//
//  CrewMember.swift
//  Moonshot
//
//  Created by jescobar on 1/13/22.
//

import Foundation

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

extension CrewMember {
    init?(role: String, astronaut: Astronaut?) {
        guard let astronaut = astronaut else {
            return nil
        }
        self.role = role
        self.astronaut = astronaut
    }
}

extension CrewMember {
    static var testMember: CrewMember {
        CrewMember(role: "Some", astronaut: .testAstronaut)
    }
}
