//
//  ResortCellView.swift
//  SnowSeeker
//
//  Created by jescobar on 3/17/22.
//

import SwiftUI

struct ResortCellView: View {
    let resort: Resort
    let isFavorite: Bool
    var body: some View {
        HStack {
            Image(resort.country)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 25)
                .clipShape(
                    RoundedRectangle(cornerRadius: 5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black, lineWidth: 1)
                )
            VStack(alignment: .leading) {
                Text(resort.name)
                    .font(.headline)
                Text("\(resort.runs) runs")
                    .foregroundColor(.secondary)
            }
            Spacer()
            if isFavorite {
                Image(systemName: "heart.fill")
                    .accessibilityLabel("This is a favorite resort")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ResortCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResortCellView(resort: .demo, isFavorite: true)
                .padding()
                .previewLayout(.sizeThatFits)
            ResortCellView(resort: .demo, isFavorite: false)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
