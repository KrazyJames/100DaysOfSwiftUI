//
//  Card.swift
//  Flashzilla
//
//  Created by jescobar on 3/5/22.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    let prompt: String
    let answer: String
}

extension Card {
    static let demo = Self.init(prompt: "Who is the director of Interstellar", answer: "Christopher Nolan")
}
