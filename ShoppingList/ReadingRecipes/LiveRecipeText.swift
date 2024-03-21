//
//  LiveRecipeText.swift
//  ShoppingList
//
//  Created by Christian Marušák on 29/11/2023.
//

import SwiftUI
import Vision
import PhotosUI
//struct LiveRecipeText: View {
//    @State var showCamera = false
//    @State var recognizedText = ""
//    @State var selectedImage : UIImage?
//    
//    func ocr(image : UIImage) {
//        
//        if let cgImage = image.cgImage {
//            
//            // Request handler
//            let handler = VNImageRequestHandler(cgImage: cgImage)
//            
//            let recognizeRequest = VNRecognizeTextRequest { (request, error) in
//                
//                // Parse the results as text
//                guard let result = request.results as? [VNRecognizedTextObservation] else {
//                    return
//                }
//                
//                // Extract the data
//                let stringArray = result.compactMap { result in
//                    result.topCandidates(1).first?.string
//                }
//                
//                // Update the UI
//                DispatchQueue.main.async {
//                    
//                    recognizedText = stringArray.joined(separator: "\n")
//                    print(recognizedText)
//                    print("Recognizing text")
//                }
//            }
//            
//            // Process the request
//            recognizeRequest.recognitionLevel = .accurate
//            do {
//                try handler.perform([recognizeRequest])
//            } catch {
//                print(error)
//            }
//            
//        }
//    }
//    
//    // Coordinator will help to preview the selected image in the View.
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var picker: accessCameraView
//        
//        init(picker: accessCameraView) {
//            self.picker = picker
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            guard let selectedImage = info[.originalImage] as? UIImage else { return }
//            self.picker.selectedImage = selectedImage
//            self.picker.isPresented.wrappedValue.dismiss()
//        }
//    }
//
//    
//    struct accessCameraView: UIViewControllerRepresentable {
//        
//        @Binding var selectedImage: UIImage?
//        @Environment(\.presentationMode) var isPresented
//        
//        func makeUIViewController(context: Context) -> UIImagePickerController {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .camera
//            imagePicker.allowsEditing = true
//            imagePicker.delegate = context.coordinator
//            return imagePicker
//        }
//        
//        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//            
//        }
//
//        func makeCoordinator() -> Coordinator {
//            return Coordinator(picker: self)
//        }
//    }
//    
//    var body: some View {
//        Button("Start scanning") {
//            self.showCamera.toggle()
//        }
//            .padding()
//            .foregroundColor(.white)
//            .background(Capsule().fill(Color.blue))
//            .fullScreenCover(isPresented: $showCamera) {
//                accessCameraView(selectedImage: self.$selectedImage)
//            }.onDisappear(perform: {
//                if let selectedSafeImage = selectedImage {
//                    ocr(image: selectedSafeImage)
//                }
//            })
//    }
//}

struct LiveRecipeText: View {
    
    @State var recognizedText = ""
    @State var imagePicker: PhotosPickerItem?
    @State var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            Text("OCR using Vission")
                .font(.title)
            
            PhotosPicker(selection: $imagePicker, matching: .images) {
                Text("select image")
                Image(uiImage: selectedImage ?? UIImage(resource: .iconLogo))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }.onChange(of: imagePicker) { _, _ in
                Task{
                    if let imagePicker,
                       let data = try? await imagePicker.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data){
                            selectedImage = image
                        }
                    }
                }
            }
            
           
            
            Button("Recognize Text"){
                ocr(inImage: selectedImage!)
            }
            
            TextEditor(text: $recognizedText)
        }
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
