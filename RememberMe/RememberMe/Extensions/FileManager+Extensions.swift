//
//  FileManager+Extensions.swift
//  RememberMe
//
//  Created by jescobar on 2/22/22.
//

import UIKit

extension FileManager {
    static var documentsDirectory: URL? {
        FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask
        ).first
    }

    func save(image: UIImage, with name: String) -> Bool {
        guard let url = Self.documentsDirectory?.appendingPathComponent(name),
              let data = image.jpegData(compressionQuality: 0.8) else { return false }
        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func loadImage(with name: String) -> UIImage? {
        guard let url = Self.documentsDirectory?.appendingPathComponent(name) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
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
