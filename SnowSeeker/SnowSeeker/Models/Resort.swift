//
//  Resort.swift
//  SnowSeeker
//
//  Created by jescobar on 3/16/22.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
}

extension Resort {
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let demo = allResorts[.zero]
    var facilityTypes: [Facility] { facilities.map(Facility.init) }

    static func sortedResorts(by sort: Sort) -> [Resort] {
        switch sort {
        case .defaultOrder:
            return allResorts
        case .alphabetical:
            return allResorts.sorted()
        case .country:
            return allResorts.sorted().sorted { lhs, rhs in
                lhs.country < rhs.country
            }
        }
    }

    enum Sort: String, CaseIterable, Identifiable {
        case defaultOrder = "Default"
        case alphabetical = "Alphabetical"
        case country = "By country"

        var id: UUID {
            .init()
        }
    }
}

extension Resort: Comparable {
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        lhs.name < rhs.name
    }
}
