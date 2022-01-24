//
//  HabitViewModel.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import Foundation

class HabitViewModel: Identifiable, ObservableObject {
    @Published var habit: Habit
    var logs: [LogViewModel] {
        habit.log.map(LogViewModel.init).reversed()
    }

    init(_ habit: Habit) {
        self.habit = habit
    }

    var id: UUID {
        habit.id
    }

    var name: String {
        habit.name
    }

    var description: String {
        habit.description
    }

    var dateAdded: Date {
        habit.dateAdded
    }

    var date: String {
        dateAdded.formatted(date: .abbreviated, time: .shortened)
    }

    var lastTime: String {
        logs.first?.date.formatted(date: .abbreviated, time: .shortened) ?? "N/A"
    }

    func addLog() {
        habit.log.append(Habit.Log(date: Date()))
    }
}

extension HabitViewModel {
    class LogViewModel: Identifiable {
        let log: Habit.Log

        init(_ log: Habit.Log) {
            self.log = log
        }

        var id: UUID {
            log.id
        }

        var date: Date {
            log.date
        }

        var formatedDate: String {
            log.date.formatted(date: .long, time: .standard)
        }
    }
}

extension HabitViewModel {
    static let demo = HabitViewModel(.demo)
    static let demoList: [HabitViewModel] = [.demo, .demo, .demo]
}
