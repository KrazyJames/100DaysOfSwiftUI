//
//  Location.swift
//  RememberMe
//
//  Created by jescobar on 2/23/22.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable {
    var id = UUID()
    let latitude: Double
    let longitude: Double
}

extension Location {
    static let demo = Location(latitude: 50, longitude: 0)

    init(_ location: CLLocationCoordinate2D) {
        self.init(latitude: location.latitude, longitude: location.longitude)
    }
}
