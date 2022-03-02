//
//  Prospect.swift
//  HotProspects
//
//  Created by jescobar on 2/27/22.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    var created = Date()
}

extension Prospect {
    convenience init(name: String = "Anonymous", emailAddress: String = "", isContacted: Bool = false) {
        self.init()
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] = []
    private var sortBy: Sorting = .recent
    private let saveKey = "SavedData"
    private let saveSortingKey = "SavedSorting"

    enum Sorting: String, CaseIterable {
        case ascendant = "Ascendant"
        case descendant = "Descendant"
        case recent = "Most recent"
        case old = "Older first"
    }

    init() {
        retrieve()
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    private func retrieve() {
        if let sorting = UserDefaults.standard.string(forKey: saveSortingKey),
           let sortBy = Sorting.init(rawValue: sorting) {
            self.sortBy = sortBy
        }
        let result: Result<[Prospect], FileManagerError> = FileManager.default.decode(saveKey)
        switch result {
        case let .success(prospects):
            people = prospects
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

    private func save() {
        let result = FileManager.default.encode(saveKey, people)
        switch result {
        case .success():
            UserDefaults.standard.setValue(sortBy.rawValue, forKey: saveSortingKey)
            return
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

    func delete(_ prospect: Prospect) {
        people.removeAll(where: { $0.id == prospect.id })
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func sort(by sorting: Sorting) {
        sortBy = sorting
        switch sorting {
        case .ascendant:
            people.sort { lhs, rhs in
                lhs.name < rhs.name
            }
        case .descendant:
            people.sort { lhs, rhs in
                lhs.name > rhs.name
            }
        case .recent:
            people.sort { lhs, rhs in
                lhs.created > rhs.created
            }
        case .old:
            people.sort { lhs, rhs in
                lhs.created < rhs.created
            }
        }
        save()
    }
}
