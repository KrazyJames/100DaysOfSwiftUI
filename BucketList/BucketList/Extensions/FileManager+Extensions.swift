//
//  FileManager+Ext.swift
//  BucketList
//
//  Created by jescobar on 2/12/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL? {
        FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask
        ).first
    }

    func decode<T: Decodable>(_ fileName: String) -> T? {
        guard let url = Self.documentsDirectory?.appendingPathComponent(fileName) else { return nil }
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func encode<T: Encodable>(_ fileName: String, _ object: T) -> Bool {
        guard let url = Self.documentsDirectory?.appendingPathComponent(fileName) else { return false }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
