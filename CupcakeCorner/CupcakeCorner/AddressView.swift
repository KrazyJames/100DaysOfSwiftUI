//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by jescobar on 1/24/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckOutView(order: order)
                }
                .disabled(!order.hasValidAddress)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
