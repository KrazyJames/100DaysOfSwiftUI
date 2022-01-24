//
//  ExpenseList.swift
//  iExpense
//
//  Created by jescobar on 1/5/22.
//

import Foundation
import SwiftUI

class ExpenseList: ObservableObject {
    @Published private var items = Set<Expense>() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            let list: [ExpenseViewModel] = items.map(ExpenseViewModel.init).sorted { lhs, rhs in
                lhs.amount < rhs.amount
            }
            personal = list.filter { viewModel in
                viewModel.expense.type == .personal
            }
            business = list.filter { viewModel in
                viewModel.expense.type == .business
            }
        }
    }

    var personal = [ExpenseViewModel]()

    var business = [ExpenseViewModel]()

    init() {
        guard let data = UserDefaults.standard.data(forKey: "Items"),
              let decoded = try? JSONDecoder().decode(Set<Expense>.self, from: data)
        else { return }
        items = decoded
    }

    func list(type: ExpenseType) -> [ExpenseViewModel] {
        switch type {
        case .personal:
            return personal
        case .business:
            return business
        }
    }

    func addItem(_ expense: Expense) {
        items.insert(expense)
    }

    func removeItems(at offsets: IndexSet, type: ExpenseType) {
        switch type {
        case .personal:
            for index in offsets {
                let removed = personal.remove(at: index)
                items.remove(removed.expense)
            }
        case .business:
            for index in offsets {
                let removed = business.remove(at: index)
                items.remove(removed.expense)
            }
        }
    }
}

struct ExpenseViewModel: Identifiable {
    let expense: Expense

    var id: UUID {
        expense.id
    }

    var type: String {
        expense.type.rawValue.capitalized
    }

    var name: String {
        expense.name
    }

    var amount: Double {
        expense.amount
    }

    var color: Color {
        if amount < 10 { return .green }
        if amount < 100 { return .orange }
        return .red
    }
}
