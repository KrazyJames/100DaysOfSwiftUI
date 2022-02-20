//
//  EditViewModel.swift
//  BucketList
//
//  Created by jescobar on 2/18/22.
//

import SwiftUI

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name: String
        @Published var description: String
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        var location: Location

        var newLocation: Location {
            var newLocation = location
            newLocation.id = .init()
            newLocation.name = name
            newLocation.description = description
            return newLocation
        }

        init(location: Location) {
            self.location = location
            self._name = Published(initialValue: location.name)
            self._description = Published(initialValue: location.description)
        }

        func fetchNearby() async {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "en.wikipedia.org"
            components.path = "/w/api.php"
            components.queryItems = [
                URLQueryItem(name: "ggscoord", value: "\(location.coordinate.latitude)|\(location.coordinate.longitude)"),
                URLQueryItem(name: "action", value: "query"),
                URLQueryItem(name: "prop", value: "coordinates|pageimages|pageterms"),
                URLQueryItem(name: "colimit", value: "50"),
                URLQueryItem(name: "piprop", value: "thumbnail"),
                URLQueryItem(name: "pithumbsize", value: "500"),
                URLQueryItem(name: "pilimit", value: "50"),
                URLQueryItem(name: "wbptterms", value: "description"),
                URLQueryItem(name: "generator", value: "geosearch"),
                URLQueryItem(name: "ggsradius", value: "10000"),
                URLQueryItem(name: "ggslimit", value: "50"),
                URLQueryItem(name: "format", value: "json")
            ]
            guard let url = components.url else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                Task { @MainActor in
                    pages = items.query.pages.values.sorted()
                    loadingState = .loaded
                }
            } catch {
                Task { @MainActor in
                    loadingState = .failed
                }
            }
        }
    }

    enum LoadingState {
        case loading, loaded, failed
    }
}
