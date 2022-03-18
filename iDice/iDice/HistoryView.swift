//
//  HistoryView.swift
//  iDice
//
//  Created by jescobar on 3/14/22.
//

import SwiftUI

struct HistoryView: View {
    @Binding var history: [HistoryModel]
    var body: some View {
        NavigationView {
            List {
                ForEach(history) { item in
                    HStack {
                        Text("\(item.value)")
                        Spacer()
                        Text("\(item.diceType.stringValue)")
                    }
                    .accessibilityElement(children: .combine)
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(
            history: .constant([.init(diceType: .sixSided, value: 5)])
        )
    }
}
