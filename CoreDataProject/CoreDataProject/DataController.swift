//
//  DataController.swift
//  CoreDataProject
//
//  Created by jescobar on 1/31/22.
//

import Foundation
import CoreData

final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData could not be loaded: \(error.localizedDescription)")
            }
        }
        // Allows you to merge same objects when they contain the same properties' values
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
