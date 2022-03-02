//
//  AddViewModel.swift
//  RememberMe
//
//  Created by jescobar on 2/22/22.
//

import UIKit
import SwiftUI
import MapKit

extension AddView {
    @MainActor internal final class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var image: UIImage?
        @Published var presentPicker = false
        @Published var region: MKCoordinateRegion = .init()
        @Published var selectedLocation: LocationViewModel?
        private let locationFetcher = LocationFetcher()

        var shownImage: Image? {
            guard let image = image else {
                return nil
            }
            return Image(uiImage: image)
        }

        var showMap: Bool {
            image != nil
        }

        var isDisabled: Bool {
            name.isEmpty || image == nil || selectedLocation == nil
        }

        func selectPicture() {
            presentPicker.toggle()
            region = .init(
                center: locationFetcher.lastKnownLocation ?? .init(
                    latitude: 0,
                    longitude: 0
                ),
                span: .init(
                    latitudeDelta: 25,
                    longitudeDelta: 25
                )
            )
        }

        func selectLocation() {
            self.selectedLocation = .init(location: .init(region.center))
        }

        func save() -> Photo? {
            if let image = image, let location = self.selectedLocation, !name.isEmpty {
                let photo = Photo(name: name, photoId: .init(), location: location.location)
                let didSave = saveImage(image, id: photo.photoId)
                if didSave {
                    return photo
                }
            }
            return nil
        }

        private func saveImage(_ image: UIImage, id: UUID) -> Bool {
            return FileManager.default.save(image: image, with: id.uuidString)
        }
    }
}
