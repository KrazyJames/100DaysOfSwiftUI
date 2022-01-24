//
//  AddHabitViewModel.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import Foundation
import SwiftUI

class AddHabitViewModel: ObservableObject {
    @Published var name = ""
    @Published var description = ""
    @Published var shouldDismiss = false
    private var listViewModel: HabitListViewModel

    var isDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    init(_ listViewModel: HabitListViewModel) {
        self.listViewModel = listViewModel
    }

    func addHabit() {
        let habit = Habit(name: name, description: description)
        listViewModel.append(.init(habit))
        shouldDismiss = true
    }
}
