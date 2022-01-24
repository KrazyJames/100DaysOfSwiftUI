//
//  Expense.swift
//  iExpense
//
//  Created by jescobar on 1/5/22.
//

import Foundation

struct Expense: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

enum ExpenseType: String, Codable, CaseIterable {
    case personal
    case business
}
