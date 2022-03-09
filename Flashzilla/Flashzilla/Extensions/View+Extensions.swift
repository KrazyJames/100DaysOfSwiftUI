//
//  View+Extensions.swift
//  Flashzilla
//
//  Created by jescobar on 3/9/22.
//

import SwiftUI

extension View {
    func stacked(
        at position: Int,
        in total: Int
    ) -> some View {
        let offset = Double(total - position)
        return self.offset(
            x: .zero,
            y: offset * 10
        )
    }
}
