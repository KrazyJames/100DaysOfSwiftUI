//
//  Overview.swift
//  WeSplit
//
//  Created by jescobar on 11/19/21.
//

import SwiftUI

struct Overview: View {
    @State private var tapCount = 0
    @State private var name = ""
    
    let students = ["Jaime", "Lennika", "Erick"]
    @State private var pickedStudent = "Jaime"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Your name is \(name)")
                }
                Section {
                    Button("Tap count \(tapCount)") {
                        tapCount += 1
                    }
                }
                Section {
                    Picker("Pick student", selection: $pickedStudent) {
                        ForEach(students, id: \.self) { student in
                            Text("\(student)")
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
