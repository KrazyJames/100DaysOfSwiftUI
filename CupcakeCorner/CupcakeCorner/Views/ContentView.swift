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
                        .accessibilityElement()
                        .accessibilityLabel("Number of cakes")
                        .accessibilityValue("\(viewModel.quantity)")
                        .accessibilityAdjustableAction { direction in
                            switch direction {
                            case .increment:
                                if viewModel.quantity < 20 { viewModel.quantity += 1 }
                            case .decrement:
                                if viewModel.quantity > 3 { viewModel.quantity -= 1 }
                            @unknown default:
                                break
                            }
                        }
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
