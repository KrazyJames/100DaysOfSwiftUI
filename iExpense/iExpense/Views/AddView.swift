//
//  AddView.swift
//  iExpense
//
//  Created by jescobar on 1/5/22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var expenses: ExpenseList
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }

                TextField("Amount", value: $amount, format: .localCurrency())
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = Expense(name: name, type: type, amount: amount)
                    expenses.addItem(item)
                    dismiss()
                }
            }

        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: ExpenseList())
    }
}
