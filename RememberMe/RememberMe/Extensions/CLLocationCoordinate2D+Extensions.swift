//
//  CLLocationCoordinate2D+Extensions.swift
//  RememberMe
//
//  Created by jescobar on 2/23/22.
//

import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: UUID {
        .init()
    }
}
