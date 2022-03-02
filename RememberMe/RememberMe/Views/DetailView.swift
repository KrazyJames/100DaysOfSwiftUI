//
//  DetailView.swift
//  RememberMe
//
//  Created by jescobar on 2/22/22.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let viewModel: PhotoViewModel
    @State private var coordinateRegion: MKCoordinateRegion

    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        self._coordinateRegion = State(
            initialValue: MKCoordinateRegion(
                center: viewModel.location.coordinate,
                span: .init(
                    latitudeDelta: 30,
                    longitudeDelta: 30
                )
            )
        )
    }

    var body: some View {
        List {
            Section {
                viewModel.image?
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 288)
                    .listRowInsets(.init())
            }
            Section {
                Map(coordinateRegion: $coordinateRegion, annotationItems: [viewModel.location]) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .frame(width: 44, height: 44)
                            .foregroundColor(.red)
                    }
                }
                .frame(height: 288)
                .listRowInsets(.init())
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(viewModel: .demo)
        }
    }
}
