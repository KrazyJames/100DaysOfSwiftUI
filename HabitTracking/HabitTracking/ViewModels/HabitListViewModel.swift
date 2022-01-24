//
//  HabitListViewModel.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import Foundation

class HabitListViewModel: ObservableObject {
    @Published var list: [HabitViewModel] = []
    @Published var isAddViewPresented = false
    var isEmpty: Bool {
        list.isEmpty
    }

    init() {
        retrieveFromDefaults()
    }

    deinit {
        saveToDefaults()
    }

    func append(_ newHabit: HabitViewModel) {
        list.append(newHabit)
    }

    func move(from: IndexSet, to: Int) {
        list.move(fromOffsets: from, toOffset: to)
    }

    func remove(at offsets: IndexSet) {
        list.remove(atOffsets: offsets)
    }

    func presentAddView() {
        isAddViewPresented.toggle()
    }

    func retrieveFromDefaults() {
        guard let data = UserDefaults.standard.data(forKey: "habits"),
              let list = try? JSONDecoder().decode([Habit].self, from: data) else { return }
        self.list = list.map(HabitViewModel.init)
    }

    func saveToDefaults() {
        let habits: [Habit] = list.map { $0.habit }
        guard let data = try? JSONEncoder().encode(habits) else { return }
        UserDefaults.standard.set(data, forKey: "habits")
    }
}

extension HabitListViewModel {
    convenience init(_ list: [HabitViewModel]) {
        self.init()
        self.list = list
    }

    static var demo: HabitListViewModel {
        .init(HabitViewModel.demoList)
    }
}
