//
//  ContentView.swift
//  CoreDataProject
//
//  Created by jescobar on 1/31/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var filterValue = ""
    @State private var predicateParameter: PredicateParameter = .beginsWith
    @State private var filterKey = "shortName"
    @State private var isConfirmationDialogPresented = false
    @State private var sortDescriptors: [SortDescriptor<Country>] = [SortDescriptor(\.fullName)]

    var body: some View {
        NavigationView {
            FilteredList(
                filterKey: filterKey,
                predicateParameter: predicateParameter,
                filterValue: filterValue,
                sortDescriptors: sortDescriptors) { (country: Country) in
                Section(country.wrappedFullName) {
                    ForEach(country.candies) { candy in
                        Text(candy.wrappedName)
                    }
                }
            }
            .navigationTitle("Countries")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sort") {
                        isConfirmationDialogPresented.toggle()
                    }
                }
                ToolbarItem {
                    Button {
                        let candy1 = Candy(context: moc)
                        candy1.name = "Nucita"
                        candy1.origin = Country(context: moc)
                        candy1.origin?.shortName = "MX"
                        candy1.origin?.fullName = "Mexico"

                        let candy2 = Candy(context: moc)
                        candy2.name = "Mazapan"
                        candy2.origin = Country(context: moc)
                        candy2.origin?.shortName = "MX"
                        candy2.origin?.fullName = "Mexico"

                        let candy3 = Candy(context: moc)
                        candy3.name = "Kit Kat"
                        candy3.origin = Country(context: moc)
                        candy3.origin?.shortName = "UK"
                        candy3.origin?.fullName = "United Kingdom"

                        let candy4 = Candy(context: moc)
                        candy4.name = "Toblerone"
                        candy4.origin = Country(context: moc)
                        candy4.origin?.shortName = "CH"
                        candy4.origin?.fullName = "Switzerland"

                        let candy5 = Candy(context: moc)
                        candy5.name = "Other"
                        candy5.origin = Country(context: moc)
                        candy5.origin?.shortName = "PO"
                        candy5.origin?.fullName = "Poland"

                        let candy6 = Candy(context: moc)
                        candy6.name = "Hershey"
                        candy6.origin = Country(context: moc)
                        candy6.origin?.shortName = "US"
                        candy6.origin?.fullName = "United States"

                        if moc.hasChanges {
                            try? moc.save()
                        }
                    } label: {
                        Label("Add samples", systemImage: "plus")
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("MX") {
                        filterKey = "shortName"
                        filterValue = "MX"
                        predicateParameter = .beginsWith
                    }
                    Button("UK") {
                        filterKey = "fullName"
                        filterValue = "Kingdom"
                        predicateParameter = .endsWith
                    }
                    Button("ends with Land") {
                        filterKey = "fullName"
                        filterValue = "land"
                        predicateParameter = .endsWith
                    }
                    Button("begins with United") {
                        filterKey = "fullName"
                        filterValue = "United"
                        predicateParameter = .beginsWith
                    }
                }
            }
            .confirmationDialog("Sort by", isPresented: $isConfirmationDialogPresented) {
                Button("Country name ascending") {
                    sortDescriptors = [SortDescriptor(\.fullName)]
                }
                Button("Country name descending") {
                    sortDescriptors = [SortDescriptor(\.fullName, order: .reverse)]
                }
                Button("Cencel", role: .cancel) { isConfirmationDialogPresented.toggle() }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
