//
//  ConfigurationView.swift
//  Edutainment
//
//  Created by jescobar on 12/14/21.
//

import SwiftUI

struct ConfigurationView: View {
    let category: Category
    @State private var table = 2
    @State private var questions = 5
    var body: some View {
        Form {
            Section("Select table") {
                Stepper("\(table)", value: $table, in: 2...12)
            }

            Section("Select Number of questions") {
                Picker("Questions", selection: $questions) {
                    ForEach([5, 10, 12], id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.segmented)
            }

            NavigationLink(destination: MultiplicationView(table: table, intents: questions)) {
                Text("Play")
            }
        }
        .navigationTitle(category.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConfigurationView(
                category: Category.multiplication
            )
        }
    }
}
