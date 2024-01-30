//
//  LiveRecipeText.swift
//  ShoppingList
//
//  Created by Christian Marušák on 29/11/2023.
//

import SwiftUI
import VisionKit
struct LiveRecipeText: View {
    var body: some View {
        Button("Start scanning") {
            print("Started scanning")
        }.padding()
        .foregroundColor(.white)
        .background(Capsule().fill(Color.blue))
    }
}

#Preview {
    LiveRecipeText()
}
