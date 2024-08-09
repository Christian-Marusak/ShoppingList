//
//  AddItems.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

struct AddItems: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddItemsVM = AddItemsVM(newItem: "testovanie NewItem", newCategory: "testovanie newCategory", newNumber: 4, newStore: .Billa, isPresented: false)
    
    var body: some View {
        Form {
            Section("Enter item and category") {
                TextField("Item name", text: $viewModel.newItem)
                TextField("Category name", text: $viewModel.newCategory)
            }
            
            Section {
                Picker("Choose number of items", selection: $viewModel.newNumber) {
                    ForEach(0...10, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                
            }
            Picker("title", selection: $viewModel.newStore) {
                ForEach(ListModel.StoreName.allCases, id: \.self) { store in
                    Text(store.rawValue)
                }
            }
        }
        Button("Add items to your shopping list"){
            let list = ListModel(
                item: viewModel.newItem,
                category: viewModel.newCategory,
                number: viewModel.newNumber,
                store: viewModel.newStore,
                bought: false
            )
            ShoppingMockData().addData(list)
            dismiss()
                        }
        }
    }

#Preview {
    AddItems(viewModel: AddItemsVM(newItem: "Here is new item", newCategory: "Here is new category", newNumber: 3, newStore: .Coop, isPresented: false))
}
