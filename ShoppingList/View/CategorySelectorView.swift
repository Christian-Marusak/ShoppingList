//
//  CategorySelectorView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

struct CategorySelectorView: View {
    @State var categories: Set<String>
    @Binding var isPresentingCategory: Bool
    @Binding var selectedCategory: String
    
    var body: some View {
        Text("Choose a Category you want to sort")
        Picker("Choose a Category you want to sort", selection: $selectedCategory) {
            ForEach(categories.sorted(), id: \.self) { category in
                Text(category)
            }
        }.frame(height: 100)
        .pickerStyle(.wheel)
        .padding()
        .onChange(of: selectedCategory) { _, _ in
            isPresentingCategory = false
        }
        
        Button("Reset") {
            selectedCategory = ""
            isPresentingCategory = false
        }
    }
}




#Preview {
    CategorySelectorView(categories: [], isPresentingCategory: .constant(false), selectedCategory: .constant(""))
}
