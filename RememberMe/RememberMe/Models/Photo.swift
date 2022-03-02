//
//  Photo.swift
//  RememberMe
//
//  Created by jescobar on 2/22/22.
//

import Foundation

struct Photo: Identifiable, Codable {
    var id = UUID()
    let name: String
    let photoId: UUID
    let location: Location
}

extension Photo {
    static let demo = Photo(name: "Abel Tesfaye", photoId: .init(), location: .demo)
}
