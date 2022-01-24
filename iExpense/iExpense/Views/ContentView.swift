//
//  ContentView.swift
//  iExpense
//
//  Created by jescobar on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddExpense = false
    @StateObject var viewModel = ExpenseList()

    var body: some View {
        NavigationView {
            List {
                ForEach(ExpenseType.allCases, id: \.self) { sectionType in
                    Section(sectionType.rawValue) {
                        ForEach(viewModel.list(type: sectionType)) { item in
                            CellView(item: item)
                        }
                        .onDelete { indexSet in
                            viewModel.removeItems(at: indexSet, type: sectionType)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

