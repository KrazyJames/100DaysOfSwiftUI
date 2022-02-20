//
//  DataController.swift
//  Bookworm
//
//  Created by jescobar on 1/27/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData could not be loaded: \(error.localizedDescription)")
            }
        }
    }
}
