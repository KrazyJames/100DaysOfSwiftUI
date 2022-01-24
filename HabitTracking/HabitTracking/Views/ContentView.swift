//
//  ContentView.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HabitListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
