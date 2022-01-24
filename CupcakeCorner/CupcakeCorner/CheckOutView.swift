//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by jescobar on 1/24/22.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title3)

                Button("Place order") {

                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckOutView(order: Order())
        }
    }
}
