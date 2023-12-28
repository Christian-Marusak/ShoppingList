//
//  AddItems.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

struct AddItems: View {
    
    @State private var newItem : String = ""
    @State private var newCategory : String = ""
    @State private var newNumber : Int = 0
    @State private var store: String = ""
    @State var selectedShop : ShoppingList.StoreName = .none
    var itemsInputCompletion : (ShoppingList) -> Void
    var freeList: Binding<[ShoppingList]>
    @Binding var isPresented: Bool
    
    
    var body: some View {
        Form {
            Section("Enter item and category") {
                TextField("Item name", text: $newItem)
                TextField("Category name", text: $newCategory)
            }
            Section("Choose number of items") {
                Picker("Number of pieces", selection: $newNumber) {
                    ForEach(0...10, id: \.self) { number in
                        Text("\(number)")
                    }
                }.pickerStyle(.menu)
                Picker("where do you buy it", selection: $selectedShop) {
                    ForEach(ShoppingList.StoreName.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }
                }.pickerStyle(.menu)
            }
            Button("Add items to your shopping list"){
                let list = ShoppingList(item: newItem, category: newCategory, number: newNumber, store: selectedShop)
                itemsInputCompletion(list)
                newItem = ""
                newNumber = 0
                newCategory = ""
                isPresented = false
                
            }
        }
    }
}

#Preview {
    AddItems(selectedShop: .Coop, itemsInputCompletion: { _ in }, freeList: .constant(([])), isPresented: .constant(false))
}
