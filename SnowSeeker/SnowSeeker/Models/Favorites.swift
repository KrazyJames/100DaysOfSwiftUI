//
//  Favorites.swift
//  SnowSeeker
//
//  Created by jescobar on 3/17/22.
//

import Foundation

final class Favorites: ObservableObject {
    private var resorts: Set<String> = []
    private let saveKey = "Favorites"

    init() {
        load()
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    private func save() {
        let result: Result<Void, FileManagerError> = FileManager.default.encode(saveKey, resorts)
        switch result {
        case .success:
            print("Saved")
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

    private func load() {
        let result: Result<Set<String>, FileManagerError> = FileManager.default.decode(saveKey)
        switch result {
        case let .success(resorts):
            self.resorts = resorts
        case let .failure(error):
            print(error.localizedDescription)
        }
    }
}
