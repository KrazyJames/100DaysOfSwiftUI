//
//  AddBookView.swift
//  Bookworm
//
//  Created by jescobar on 1/28/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = ""
    @State private var review = ""

    private var isDisabled: Bool {
        title.isEmpty ||
        author.isEmpty ||
        genre.isEmpty ||
        review.isEmpty ||
        rating == .zero
    }

    let genres = ["Fantasy", "Horror", "Kid", "Mystery", "Poetry", "Romance", "Thriller", "Self Growth", "Personal Finance", "Technology", "Math"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                Section {
                    Button("Save") {
                        let new = Book(context: moc)
                        new.id = .init()
                        new.title = title
                        new.author = author
                        new.rating = Int16(rating)
                        new.genre = genre
                        new.review = review
                        new.date = .now
                        try? moc.save()
                        dismiss()
                    }.disabled(isDisabled)
                }
            }
            .navigationBarTitle("Add book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
