//
//  Habit.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var dateAdded = Date()
    var log = [Log]()

    public struct Log: Identifiable, Codable {
        var id = UUID()
        let date: Date
    }
}

extension Habit {
    static var demo: Habit {
        .init(name: "Read", description: "Description", log: [Log(date: Date())])
    }

    static var demoList: [Habit] {
        [.demo, .demo, .demo]
    }
}
