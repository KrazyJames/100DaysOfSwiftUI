//
//  ContentView.swift
//  WordScramble
//
//  Created by jescobar on 12/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var words = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    @FocusState private var isTextFieldFocused: FocusedTextField?

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isAlertShown = false

    private enum FocusedTextField: Hashable {
        case newWord
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.none)
                        .focused($isTextFieldFocused, equals: .newWord)
                }
                Section {
                    ForEach(words, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addWord)
        }
        .onAppear(perform: startGame)
        .alert(alertTitle, isPresented: $isAlertShown) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    private func addWord() {
        let trimmedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedWord.count > .zero else { return }
        if !words.contains(trimmedWord) {
            if isPossible(trimmedWord) {
                if isRealWord(trimmedWord) {
                    words.insert(trimmedWord, at: .zero)
                } else {
                    showAlert(title: "Word is not valid", message: "That's not a valid word in English")
                }
            } else {
                showAlert(title: "Word is not possible", message: "You can not spell '\(trimmedWord)' from '\(rootWord)'")
            }
        } else {
            showAlert(title: "Word already used", message: "Try with another one")
        }
        newWord = ""
        isTextFieldFocused = .newWord
    }

    private func isPossible(_ word: String) -> Bool {
        var tempRoot = rootWord

        for letter in word {
            if let position = tempRoot.firstIndex(of: letter) {
                tempRoot.remove(at: position)
            } else {
                return false
            }
        }

        return true
    }

    private func isRealWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: .zero, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: .zero, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isAlertShown = true
    }

    private func startGame() {
        guard let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("Could not load the file")
        }
        guard let content = try? String(contentsOf: fileUrl) else {
            fatalError("Could not get string from URL: \(fileUrl.absoluteString)")
        }
        let gameWords = content.components(separatedBy: .newlines)
        guard let randomWord = gameWords.randomElement() else {
            fatalError("Could not get a random word, array contained \(gameWords.count) words")
        }
        rootWord = randomWord
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
