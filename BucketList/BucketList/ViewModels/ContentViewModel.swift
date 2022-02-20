//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by jescobar on 2/17/22.
//

import Foundation
import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 50,
                longitude: 0
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 25,
                longitudeDelta: 25
            )
        )
        @Published private(set) var locations = [Location]()
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var showAlert = false
        var alertMessage = ""

        init() {
            guard let data: [Location] = FileManager.default.decode("saved-places.json") else { return }
            locations = data
        }

        func save() {
            let didSave = FileManager.default.encode("saved-places.json", locations)
            if !didSave {
                alertMessage = "Unable to save places"
                showAlert = true
            }
        }

        func selectPlace(_ place: Location) {
            selectedPlace = place
        }

        func createLocation() {
            let location = Location(
                id: .init(),
                name: "New location",
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )
            locations.append(location)
            save()
        }

        func update(location newLocation: Location) {
            guard let selectedPlace = selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = newLocation
                save()
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "We need to unlock your data"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        guard let authError = authError else { return }
                        print(authError.localizedDescription)
                    }
                }
            } else {
                guard let error = error else { return }
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}
