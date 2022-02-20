//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by jescobar on 1/24/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var viewModel: OrderViewModel
    var body: some View {
        Form {
            Section {
                TextField("Name",
                          text: $viewModel.name)
                TextField("Address",
                          text: $viewModel.streetAddress)
                TextField("City",
                          text: $viewModel.city)
                TextField("Zip",
                          text: $viewModel.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckOutView(viewModel: viewModel)
                }
                .disabled(!viewModel.hasValidAddress)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(viewModel: OrderViewModel())
        }
    }
}
