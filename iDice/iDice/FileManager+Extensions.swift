//
//  FileManager+Extensions.swift
//  iDice
//
//  Created by jescobar on 3/14/22.
//

import Foundation

enum FileManagerError: Error {
    case invalidURL, cannotDecode, cannotEncode
}

extension FileManager {
    static var documentsDirectory: URL? {
        FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask
        ).first
    }

    func decode<T: Decodable>(_ fileName: String) -> Result<T, FileManagerError> {
        guard let url = Self.documentsDirectory?.appendingPathComponent(fileName) else { return .failure(.invalidURL) }
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let object = try decoder.decode(T.self, from: data)
            return .success(object)
        } catch {
            print(error.localizedDescription)
            return .failure(.cannotDecode)
        }
    }

    func encode<T: Encodable>(_ fileName: String, _ object: T) -> Result<Void, FileManagerError> {
        guard let url = Self.documentsDirectory?.appendingPathComponent(fileName) else { return .failure(.invalidURL) }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            return .success(())
        } catch {
            print(error.localizedDescription)
            return .failure(.cannotEncode)
        }
    }
}
