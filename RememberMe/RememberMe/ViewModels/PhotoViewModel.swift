//
//  PhotoViewModel.swift
//  RememberMe
//
//  Created by jescobar on 2/23/22.
//

import SwiftUI
import UIKit
import MapKit

struct PhotoViewModel: Identifiable {
    let photo: Photo
    private var uiImage: UIImage?

    init(photo: Photo) {
        self.photo = photo
        self.uiImage = FileManager.default.loadImage(with: photo.photoId.uuidString)
    }

    var id: UUID {
        photo.id
    }

    var name: String {
        photo.name
    }

    var location: LocationViewModel {
        .init(location: photo.location)
    }

    var image: Image? {
        guard let uiImage = uiImage else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}

struct LocationViewModel: Identifiable {
    let location: Location

    var id: UUID {
        location.id
    }

    var coordinate: CLLocationCoordinate2D {
        .init(latitude: location.latitude, longitude: location.longitude)
    }
}

extension PhotoViewModel {
    init() {
        self.photo = .demo
        self.uiImage = UIImage(named: "demo")
    }
    static let demo = Self.init()
}
