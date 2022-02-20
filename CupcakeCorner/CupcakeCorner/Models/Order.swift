//
//  Order.swift
//  CupcakeCorner
//
//  Created by jescobar on 1/24/22.
//

import Foundation

struct Order: Codable {
    let type: Int
    let quantity: Int

    let extraFrosting: Bool
    let addSprinkles: Bool

    let name: String
    let streetAddress: String
    let city: String
    let zip: String
}
