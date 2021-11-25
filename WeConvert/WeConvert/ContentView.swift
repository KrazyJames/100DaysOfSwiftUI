//
//  ContentView.swift
//  WeConvert
//
//  Created by jescobar on 11/23/21.
//

import SwiftUI

enum ConvertionUnit: String, CaseIterable, Identifiable {
    var id: Self {
        self
    }
    
    case celsius
    case fahrenheit
    case kelvin
}

struct ContentView: View {
    @State private var fromUnit: ConvertionUnit = .celsius
    @State private var quantity: Double = .zero
    @State private var toUnit: ConvertionUnit = .fahrenheit
    private var result: Double {
        convert(quantity, from: fromUnit, to: toUnit)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature in \(fromUnit.rawValue)", value: $quantity, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("", selection: $fromUnit) {
                        ForEach(ConvertionUnit.allCases) { unit in
                            Text("\(unit.rawValue.capitalized)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert from")
                }
                Section {
                    Picker("", selection: $toUnit) {
                        ForEach(ConvertionUnit.allCases) { unit in
                            Text("\(unit.rawValue.capitalized)")
                        }
                    }
                    .pickerStyle(.segmented)

                    HStack {
                        Spacer()
                        Text(result, format: .number)
                        Spacer()
                    }
                } header: {
                    Text("Convert to")
                }
            }
            .navigationTitle("WeConvert")
        }
    }

    private func convert(_ value: Double, from unitFrom: ConvertionUnit, to unitTo: ConvertionUnit) -> Double {
        switch unitFrom {
        case .celsius:
            switch unitTo {
            case .celsius:
                return value
            case .fahrenheit:
                return (value * 1.8) + 32
            case .kelvin:
                return value + 273.15
            }
        case .fahrenheit:
            switch unitTo {
            case .celsius:
                return (value - 32) / 1.8
            case .fahrenheit:
                return value
            case .kelvin:
                return (value + 459.67) / 1.8
            }
        case .kelvin:
            switch unitTo {
            case .celsius:
                return value - 273.15
            case .fahrenheit:
                return (value * 1.8) - 459.67
            case .kelvin:
                return value
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
