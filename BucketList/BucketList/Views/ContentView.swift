//
//  ContentView.swift
//  BucketList
//
//  Created by jescobar on 2/12/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        content
        .alert("Something went wrong", isPresented: $viewModel.showAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }

    @ViewBuilder
    var content: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion,
                    annotationItems: viewModel.locations
                ) { location in
                    MapAnnotation(
                        coordinate: location.coordinate
                    ) {
                        StarAnnotation(
                            location: location,
                            viewModel: viewModel
                        )
                    }
                }
                .ignoresSafeArea()
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        PlusButton {
                            viewModel.createLocation()
                        }
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct StarAnnotation: View {
    let location: Location
    @ObservedObject var viewModel: ContentView.ViewModel
    var body: some View {
        VStack {
            Image(systemName: "star.circle")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 44,
                       height: 44)
                .background(.white)
                .clipShape(Circle())
            Text(location.name)
                .fixedSize()
        }
        .onTapGesture {
            viewModel.selectPlace(location)
        }
    }
}

struct PlusButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding()
                .font(.largeTitle)
        }
        .background(.blue.opacity(0.7))
        .clipShape(Circle())
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton(action: {})
            .previewLayout(.sizeThatFits)
    }
}
