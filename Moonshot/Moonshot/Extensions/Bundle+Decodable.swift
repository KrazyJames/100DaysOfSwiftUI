//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by jescobar on 1/12/22.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file)")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) in the bundle")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode data from \(file) in the bundle")
        }
        return loaded
    }
}
