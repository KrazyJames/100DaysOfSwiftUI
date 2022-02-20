//
//  ContentView.swift
//  Bookworm
//
//  Created by jescobar on 1/27/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>

    @State private var showAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        CellView(book: book)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddView) {
            AddBookView()
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            moc.delete(book)
        }
//        try? moc.save()
    }
}

struct CellView: View {
    let book: Book
    var body: some View {
        HStack {
            EmojiRatingView(rating: book.rating)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(book.title ?? "Unknown")
                    .font(.headline)
                    .foregroundColor(book.rating < 2 ? .red : .primary)
                Text(book.author ?? "Unknown")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
