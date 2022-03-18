//
//  DiceType.swift
//  iDice
//
//  Created by jescobar on 3/14/22.
//

import Foundation

enum DiceType: Int, CaseIterable, Identifiable, Codable {
    case fourSided = 4
    case sixSided = 6
    case eightSided = 8
    case tenSided = 10
    case twelveSided = 12
    case twentySided = 20
    case hundredSided = 100

    var id: UUID {
        .init()
    }

    var stringValue: String {
        switch self {
        case .fourSided:
            return "4-sided"
        case .sixSided:
            return "6-sided"
        case .eightSided:
            return "8-sided"
        case .tenSided:
            return "10-sided"
        case .twelveSided:
            return "12-sided"
        case .twentySided:
            return "20-sided"
        case .hundredSided:
            return "100-sided"
        }
    }
}
