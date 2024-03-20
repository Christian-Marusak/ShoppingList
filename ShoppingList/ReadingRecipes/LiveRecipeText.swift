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
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    @State private var photosPicker: PhotosPickerItem?
    
    
    
    func ocr(image : UIImage) {
        
        if let cgImage = image.cgImage {
            
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
                    print("Started scanning")
                    recognizedText = stringArray.joined(separator: "\n")
                    print(recognizedText)
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
    
    var body: some View {
        Button("Start scanning") {
            self.showCamera.toggle()
        }.padding()
            .foregroundColor(.white)
            .background(Capsule().fill(Color.blue))
        
        PhotosPicker("Photos", selection: $photosPicker)
    }
}






#Preview {
    LiveRecipeText()
}
