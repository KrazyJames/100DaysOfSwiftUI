//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by jescobar on 1/23/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = OrderViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type",
                           selection: $viewModel.type) {
                        ForEach(OrderViewModel.types.indices) {
                            Text(OrderViewModel.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(viewModel.quantity)",
                            value: $viewModel.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?",
                           isOn: $viewModel.specialRequestEnabled.animation())
                    if viewModel.specialRequestEnabled {
                        Toggle("Add extra frosting",
                               isOn: $viewModel.extraFrosting)
                        Toggle("Add extra sprinkles",
                               isOn: $viewModel.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
