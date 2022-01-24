//
//  Astronaut.swift
//  Moonshot
//
//  Created by jescobar on 1/12/22.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

extension Astronaut {
    static var testAstronaut: Astronaut {
        Astronaut(id: "armstrong", name: "Neil Armstrong", description: "Description of Neil")
    }
}
