//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by jescobar on 1/24/22.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var viewModel: OrderViewModel
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(
                    url: URL(
                        string: "https://hws.dev/img/cupcakes@3x.jpg"),
                    scale: 3
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your cost is \(viewModel.cost, format: .currency(code: "USD"))")
                    .font(.title3)

                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle,
               isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }

    func placeOrder() async {
        guard let data = try? JSONEncoder().encode(viewModel.order) else { return }
        var request = URLRequest(
            url: URL(
                string: "https://reqres.in/api/cupcakes")!)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request,
                from: data
            )
            let decodedOrder = try JSONDecoder().decode(Order.self,
                                                        from: data)
            alertTitle = "Thank you!"
            alertMessage = "Your order for \(decodedOrder.quantity) x \(OrderViewModel.types[decodedOrder.type].lowercased()) cupcakes is on its way"
            showAlert = true
        } catch {
            alertTitle = "We are sorry"
            alertMessage = "We could not process your order right now"
            showAlert = true
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckOutView(viewModel: OrderViewModel())
        }
    }
}
