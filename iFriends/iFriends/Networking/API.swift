//
//  API.swift
//  iFriends
//
//  Created by jescobar on 2/3/22.
//

import Foundation

struct API {
    static let url: URL = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

    static func load<T: Decodable>(
        url: URL,
        _ decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(T.self, from: data)
    }
}
