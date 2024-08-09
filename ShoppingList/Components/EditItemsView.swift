//
//  EditItemsView.swift
//  ShoppingList
//
//  Created by Christián on 07/08/2024.
//

import SwiftUI

struct EditItemsView: View {
    
    
    @State var newItem = "testovanie newItem"
    @State var newCategory = "testovanie newCategory"
    @State var newNumber = 2
    @State var newStore: ListModel.StoreName = .Biedronka
    
    var body: some View {
        Form {
            Section("Enter item and category") {
                TextField("Item name", text: $newItem)
                TextField("Category name", text: $newCategory)
            }
            
            Section {
                Picker("Choose number of items", selection: $newNumber) {
                    ForEach(0...10, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                
            }
            Picker("title", selection: $newStore) {
                ForEach(ListModel.StoreName.allCases, id: \.self) { store in
                    Text(store.rawValue)
                }
            }
        }
        Button("Add items to your shopping list"){
            let list = ListModel(
                item: newItem,
                category: newCategory,
                number: newNumber,
                store: newStore,
                bought: false
            )
            ShoppingMockData().addData(list)

        }
        
        }
}

#Preview {
    EditItemsView()
}
