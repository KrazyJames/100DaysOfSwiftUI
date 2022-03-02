//
//  ProspectCellView.swift
//  HotProspects
//
//  Created by jescobar on 3/2/22.
//

import SwiftUI

struct ProspectCellView: View {
    let prospect: Prospect
    let filter: ProspectsView.FilterType
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.emailAddress)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if prospect.isContacted && filter == .none {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 32, height: 32)
            }
        }
    }
}

struct ProspectCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProspectCellView(prospect: Prospect(emailAddress: "uncontacted@yourmail.com", isContacted: false), filter: .none)
                .previewDisplayName("Uncontacted - Everyone")
                .previewLayout(.sizeThatFits)
                .padding()
            ProspectCellView(prospect: Prospect(emailAddress: "contacted@yourmail.com", isContacted: true), filter: .none)
                .previewDisplayName("Contacted - Everyone")
                .previewLayout(.sizeThatFits)
                .padding()
            ProspectCellView(prospect: Prospect(emailAddress: "contacted@yourmail.com", isContacted: true), filter: .contacted)
                .previewDisplayName("Contacted - Contacted")
                .previewLayout(.sizeThatFits)
                .padding()
            ProspectCellView(prospect: Prospect(emailAddress: "uncontacted@yourmail.com", isContacted: false), filter: .contacted)
                .previewDisplayName("Uncontacted - Uncontacted")
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
