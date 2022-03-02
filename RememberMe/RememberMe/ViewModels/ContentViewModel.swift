//
//  ContentViewModel.swift
//  RememberMe
//
//  Created by jescobar on 2/22/22.
//

import Foundation

extension ContentView {
    @MainActor internal final class ViewModel: ObservableObject {
        @Published var list: [PhotoViewModel] = []
        @Published var presentAddView = false
        @Published var showAlert = false
        var message = ""
        var title = ""

        init(_ isDemo: Bool = false) {
            if isDemo {
                return
            }
            let photos: [Photo]? = FileManager.default.decode("photos_db")
            guard let photos = photos else { return }
            list = photos.map { PhotoViewModel(photo: $0) }
        }

        func showAddView() {
            presentAddView.toggle()
        }

        func delete(_ offsets: IndexSet) {
            list.remove(atOffsets: offsets)
            _ = save()
        }

        func move(_ fromOffsets: IndexSet, _ toOffset: Int) {
            list.move(fromOffsets: fromOffsets, toOffset: toOffset)
            _ = save()
        }

        func save(_ photo: Photo) {
            list.append(PhotoViewModel(photo: photo))
            let didSave = save()
            message = didSave ? "\(photo.name) was added" : "We could not save your photo"
            title = didSave ? "Photo saved successfully" : "Something went wrong"
            showAlert = true
        }

        private func save() -> Bool {
            let photos: [Photo] = list.map { $0.photo }
            return FileManager.default.encode("photos_db", photos)
        }
    }
}

extension ContentView.ViewModel {
    convenience init(_ list: [PhotoViewModel]) {
        self.init(true)
        self.list = list
    }
    static let demo = ContentView.ViewModel([.demo])
}
