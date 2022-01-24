//
//  ContentView.swift
//  Edutainment
//
//  Created by jescobar on 12/14/21.
//

import SwiftUI

enum Category: String, CaseIterable {
    case addition, substraction, multiplication, division
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases, id: \.self) { category in
                    NavigationLink(destination: getConfigurationView(for: category)) {
                        Text(category.rawValue.capitalized)
                    }
                }
            }
            .navigationTitle("Edutainment")
        }
    }

    @ViewBuilder
    func getConfigurationView(for category: Category) -> some View {
        switch category {
        case .addition:
            EmptyView()
        case .substraction:
            EmptyView()
        case .multiplication:
            ConfigurationView(category: category)
        case .division:
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
