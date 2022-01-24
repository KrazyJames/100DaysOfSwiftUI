//
//  HabitDetailsView.swift
//  HabitTracking
//
//  Created by jescobar on 1/21/22.
//

import SwiftUI

struct HabitDetailsView: View {
    @ObservedObject var viewModel: HabitViewModel
    var body: some View {
        Form {
            Section("Info") {
                HStack {
                    Text("Description")
                    Spacer()
                    Text(viewModel.description)
                }
                HStack {
                    Text("Date Added")
                    Spacer()
                    Text(viewModel.date)
                }
                HStack {
                    Text("Last time")
                    Spacer()
                    Text(viewModel.lastTime)
                }
            }

            Section("Logs") {
                ForEach(viewModel.logs) { log in
                    Text(log.formatedDate)
                }
            }
        }
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.addLog()
            } label: {
                Image(systemName: "plus")
            }

        }
    }
}

struct HabitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HabitDetailsView(
                viewModel: .demo
            )
        }
    }
}
