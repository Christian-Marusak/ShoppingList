//
//  LiveRecipeText.swift
//  ShoppingList
//
//  Created by Christian Marušák on 29/11/2023.
//

import SwiftUI
import Vision
import PhotosUI

struct LiveRecipeText: View {
    
    @State var recognizedText = ""
    @State var imagePicker: PhotosPickerItem?
    @State var selectedImage: UIImage = .iconLogo
    @State private var showPhotoOptions = false
    @State private var photoSource: PhotoSource?
    
    enum PhotoSource: Identifiable {
        case photoLibrary
        case camera
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {showPhotoOptions.toggle()}, label: {
                Capsule()
                    .overlay {
                        Text("Select picture to scan")
                            .foregroundStyle(.white)
                    }
                    .frame(width: 200,height: 40)
                
            })
            
            
            Button(action: {
                ocr(inImage: selectedImage)
            }, label: {
                Capsule()
                    .overlay {
                        Text("scan image")
                            .foregroundStyle(.white)
                    }
                    .frame(width: 200,height: 40)
                    .foregroundStyle(.red)
                
            })
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            TextEditor(text: $recognizedText)
        }.fullScreenCover(item: $photoSource) { source in
            switch source {
            case .photoLibrary: ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage).ignoresSafeArea()
            case .camera: ImagePicker(sourceType: .camera, selectedImage: $selectedImage).ignoresSafeArea()
            }
        }
        
        .actionSheet(isPresented: $showPhotoOptions, content: {
            ActionSheet(title: Text("Choose camera or photo library"), buttons: [
                .default(Text("Camera"), action: {
                    self.photoSource = .camera
                }),
                .default(Text("Photo library"), action: {
                    self.photoSource = .photoLibrary
                })
            ])
        })
        .padding()
        
    }
    
    
    func ocr(inImage: UIImage) {
        
        
        if let cgImage = inImage.cgImage {
            
            // Request handler
            let handler = VNImageRequestHandler(cgImage: cgImage)
            
            let recognizeRequest = VNRecognizeTextRequest { (request, error) in
                
                // Parse the results as text
                guard let result = request.results as? [VNRecognizedTextObservation] else {
                    return
                }
                
                // Extract the data
                let stringArray = result.compactMap { result in
                    result.topCandidates(1).first?.string
                }
                
                // Update the UI
                DispatchQueue.main.async {
                    recognizedText = stringArray.joined(separator: "\n")
                }
            }
            
            // Process the request
            recognizeRequest.recognitionLevel = .accurate
            do {
                try handler.perform([recognizeRequest])
            } catch {
                print(error)
            }
            
        }
    }
}




#Preview {
    LiveRecipeText()
}
