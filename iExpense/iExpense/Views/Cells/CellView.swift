//
//  CellView.swift
//  iExpense
//
//  Created by jescobar on 1/5/22.
//

import SwiftUI

struct CellView: View {
    let item: ExpenseViewModel

    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Spacer()
            Text(item.amount,
                 format: .localCurrency())
                .foregroundColor(item.color)
                .bold()
        }
        .accessibilityElement()
        .accessibilityLabel(Text("\(item.name), ammount: ") + Text(item.amount, format: .localCurrency()))
        .accessibilityHint("Expense type: \(item.type)")
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(item: ExpenseViewModel(expense: Expense(name: "Item", type: .personal, amount: 100)))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

extension FormatStyle {
    public static func localCurrency<Value>() -> Self where Self == FloatingPointFormatStyle<Value>.Currency, Value : BinaryFloatingPoint {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
