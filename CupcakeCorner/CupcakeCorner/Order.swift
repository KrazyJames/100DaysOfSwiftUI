//
//  Order.swift
//  CupcakeCorner
//
//  Created by jescobar on 1/24/22.
//

import Foundation

final class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false

    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""

    var hasValidAddress: Bool {
        !(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
          streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
          city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
          zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complex cakes cost more
        cost += (Double(type) / 2)

        // $1 per cake with extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $.50 per cake with sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
