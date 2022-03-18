//
//  ResortView.swift
//  SnowSeeker
//
//  Created by jescobar on 3/16/22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    @EnvironmentObject var favorites: Favorites

    @State private var selectedFacility: Facility?
    @State private var showAlert = false

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading,
                   spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Credit: \(resort.imageCredit)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(.horizontal, 5)
                                .background(.black)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 5)
                                )
                                .opacity(0.5)
                        }
                        .padding(5)
                    }
                }
                .accessibilityElement(children: .combine)
                HStack {
                    if horizontalSizeClass == .compact &&
                        dynamicTypeSize > .large {
                        VStack(spacing: 10) {
                            ResortDetailsView(resort: resort)
                        }
                        VStack(spacing: 10) {
                            SkiDetailsView(resort: resort)
                        }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.quaternary)
                Group {
                    Text(resort.description)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Facilities")
                            .font(.headline)
                        HStack {
                            ForEach(resort.facilityTypes) { facility in
                                Button {
                                    selectedFacility = facility
                                    showAlert = true
                                } label: {
                                    facility.icon
                                        .font(.title)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                } label: {
                    Label(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites", systemImage: favorites.contains(resort) ? "heart.fill" : "heart")
                }
                .tint(.red)
            }
        }
        .alert(selectedFacility?.name ?? "More information", isPresented: $showAlert, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: .demo)
        }
        .environmentObject(Favorites())
        .environment(\.sizeCategory, .extraExtraLarge)
    }
}
