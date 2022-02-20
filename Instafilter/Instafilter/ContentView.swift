//
//  ContentView.swift
//  Instafilter
//
//  Created by jescobar on 2/5/22.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 20.0
    @State private var filterScale = 1.0
    @State private var showPickerSheet = false
    @State private var showFilterDialog = false
    @State private var inputImage: UIImage?
    @State private var outputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    let saver = ImageSaver()
    var isDisabled: Bool {
        image == nil
    }
    @State private var hasIntensity = false
    @State private var hasRadius = false
    @State private var hasScale = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select an image")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showPickerSheet.toggle()
                }

                VStack {
                    if hasIntensity {
                        HStack {
                            Text("Intensity")
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity) { _ in applyProcessing() }
                        }
                    }
                    if hasRadius {
                        HStack {
                            Text("Radius")
                            Slider(value: $filterRadius, in: 20.0...200.0)
                                .onChange(of: filterRadius) { _ in applyProcessing() }
                        }
                    }
                    if hasScale {
                        HStack {
                            Text("Scale")
                            Slider(value: $filterScale)
                                .onChange(of: filterScale) { _ in applyProcessing() }
                        }
                    }
                }
                .padding(.vertical)

                HStack {
                    Button("Change filter") {
                        showFilterDialog.toggle()
                    }
                    Spacer()
                    Button("Save", action: save)
                        .disabled(isDisabled)
                }
            }
            .padding()
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showPickerSheet) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showFilterDialog) {
                Button("Sepia Tone") {
                    setFilter(.sepiaTone())
                }
                Button("Pixellate") {
                    setFilter(.pixellate())
                }
                Button("Crystallize") {
                    setFilter(.crystallize())
                }
                Button("Edges") {
                    setFilter(.edges())
                }
                Button("Gaussian Blur") {
                    setFilter(.gaussianBlur())
                }
                Button("Vignette") {
                    setFilter(.vignette())
                }
                Button("Bump distorsion") {
                    setFilter(.bumpDistortion())
                }
                Button("Box blur") {
                    setFilter(.boxBlur())
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        hasIntensity = false
        hasScale = false
        hasRadius = false
        if inputKeys.contains(kCIInputIntensityKey) {
            hasIntensity = true
            currentFilter.setValue(Float(filterIntensity), forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            hasRadius = true
            currentFilter.setValue(Float(filterRadius), forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            hasScale = true
            currentFilter.setValue(Float(filterScale), forKey: kCIInputScaleKey)
        }
        guard let finalImage = currentFilter.outputImage else { return }
        if let cgImage = context.createCGImage(finalImage, from: finalImage.extent) {
            let uiImage = UIImage.init(cgImage: cgImage)
            outputImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }

    func save() {
        guard let processedImage = outputImage else { return }
        saver.successHandler = {
            print("Success!")
        }
        saver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        saver.writeToPhotoAlbum(image: processedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
