//
//  ContentView.swift
//  RememberMe
//
//  Created by jescobar on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.list) { photo in
                    NavigationLink(
                        destination: DetailView(
                            viewModel: photo
                        )
                    ) {
                        CellView(photo: photo)
                    }
                }
                .onDelete { viewModel.delete($0) }
                .onMove { viewModel.move($0, $1) }
            }
            .navigationTitle("RememberMe")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.showAddView()
                    } label: {
                        Label {
                            Text("Add person")
                        } icon: {
                            Image(systemName: "plus")
                        }
                    }
                }
                ToolbarItem(placement: .navigation) {
                    EditButton()
                }
            }
            .sheet(isPresented: $viewModel.presentAddView) {
                AddView { photo in
                    guard let photo = photo else { return }
                    viewModel.save(photo)
                }
            }
            .alert(viewModel.title, isPresented: $viewModel.showAlert) {
                Button("Ok") { }
            }
        }
    }
}

struct CellView: View {
    let photo: PhotoViewModel
    var body: some View {
        HStack {
            photo.image?
                .resizable()
                .scaledToFill()
                .frame(width: 64,
                       height: 64)
                .clipShape(Circle())
            Text(photo.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: ContentView.ViewModel([.demo])
        )
    }
}
