//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by jescobar on 3/16/22.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
            }

            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)cm")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SkiDetailsView(resort: .demo)
            }
            .padding()
            .previewLayout(.sizeThatFits)
            HStack {
                SkiDetailsView(resort: .demo)
            }
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
