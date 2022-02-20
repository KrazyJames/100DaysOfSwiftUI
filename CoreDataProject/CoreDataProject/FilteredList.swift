//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by jescobar on 2/2/22.
//

import SwiftUI
import CoreData

enum PredicateParameter: String {
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
}

typealias ReturnedContent<T: NSManagedObject & Identifiable, Content: View> = (T) -> Content

struct FilteredList<T: NSManagedObject & Identifiable, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    let content: ReturnedContent<T, Content>

    var body: some View {
        List(fetchRequest) { item in
            self.content(item)
        }
    }

    init(
        filterKey: String,
        predicateParameter: PredicateParameter = .beginsWith,
        filterValue: String,
        sortDescriptors: [SortDescriptor<T>],
        @ViewBuilder content: @escaping ReturnedContent<T, Content>) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(
                format: "%K \(predicateParameter.rawValue) %@",
                filterKey,
                filterValue
            )
        )
        self.content = content
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList<Candy, EmptyView>(filterKey: "", filterValue: "", sortDescriptors: [], content: { _ in return EmptyView() })
    }
}
