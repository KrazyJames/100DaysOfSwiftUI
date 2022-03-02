//
//  AddView.swift
//  RememberMe
//
//  Created by jescobar on 2/22/22.
//

import SwiftUI
import MapKit

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ViewModel()
    var onSave: (Photo?) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section("Info") {
                    TextField("Name", text: $viewModel.name)
                }
                Section("Picture") {
                    ZStack {
                        Rectangle()
                            .fill(.clear)
                        Label {
                            Text("Tap to select picture")
                        } icon: {
                            Image(systemName: "photo")
                        }
                        .foregroundColor(.accentColor)
                        viewModel.shownImage?
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 288)
                    }
                    .listRowInsets(.init())
                    .onTapGesture {
                        viewModel.selectPicture()
                    }
                }
                if viewModel.showMap {
                    Section("Location") {
                        ZStack {
                            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: [viewModel.selectedLocation].compactMap { $0 }) { location in
                                MapAnnotation(coordinate: location.coordinate) {
                                    Image(systemName: "mappin.circle.fill")
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(.red)
                                }
                            }
                            .frame(height: 288)
                            Button {
                                viewModel.selectLocation()
                            } label: {
                                Image(systemName: "mappin.circle.fill")
                            }
                            .frame(width: 44, height: 44)
                            .background(.blue.opacity(0.3))
                            .clipShape(Circle())
                        }
                        .listRowInsets(.init())
                    }
                }
            }
            .navigationTitle("Add new")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        onSave(viewModel.save())
                        dismiss()
                    }.disabled(viewModel.isDisabled)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: { dismiss() })
                }
            }
            .sheet(isPresented: $viewModel.presentPicker) {
                ImagePicker(image: $viewModel.image)
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView { _ in }
    }
}
