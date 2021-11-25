//
//  ContentView.swift
//  WeSplit
//
//  Created by jescobar on 11/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var people = 2
    @State private var tip = 15
    @FocusState private var isAmountFocused: Bool
    
    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    let tips = [0, 5, 10, 15, 20, 25, 30]
    
    private var total: Double {
        let tipPercentage = Double(tip)
        let tipValue = amount * ((tipPercentage / 100) + 1)
        return tipValue
    }
    
    private var totalPerPerson: Double {
        total / Double(people + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Price", value: $amount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                }
                Section(header: Text("Tip percentage")) {
                    Picker("Tip percentage", selection: $tip) {
                        ForEach(tips, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("Total")) {
                    Text(total, format: currencyFormat)
                }
                Section(header: Text("Amount per person")) {
                    Text(totalPerPerson, format: currencyFormat)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
