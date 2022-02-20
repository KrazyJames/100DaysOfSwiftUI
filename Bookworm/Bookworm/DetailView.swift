//
//  DetailView.swift
//  Bookworm
//
//  Created by jescobar on 1/29/22.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            .accessibilityElement()
            .accessibilityLabel("\(book.genre ?? "No genre provided")")
            .accessibilityAddTraits(.isImage)

            Text(book.author ?? "")
                .font(.title)
                .foregroundColor(.secondary)
                .accessibilityLabel("Author: \(book.author ?? "Unknown")")

            Text(book.date?.formatted(date: .long, time: .omitted) ?? "N/D")

            Text(book.review ?? "N/A")
                .padding()
                .accessibilityLabel("Review \(book.review ?? "Review no provided")")

            RatingView(rating: .constant(Int(book.rating)))
                .accessibilityElement()
                .accessibilityLabel("Rating \(book.rating == 1 ? "1 star" : "\(book.rating) stars")")
        }
        .navigationTitle(book.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showDeleteAlert.toggle()
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .alert("Delete book", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Want to delete \(book.title ?? "")?")
        }
    }

    func deleteBook() {
        moc.delete(book)
//        try? moc.save()
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(book: Book())
    }
}
