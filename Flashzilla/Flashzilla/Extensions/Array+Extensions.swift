//
//  Array+Extensions.swift
//  Flashzilla
//
//  Created by jescobar on 3/9/22.
//

import Foundation

extension Array where Element: Equatable {
    func isLast(_ element: Element) -> Bool {
        self.last == element
    }
}
