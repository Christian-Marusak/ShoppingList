//
//  AddItemsVM.swift
//  ShoppingList
//
//  Created by Christián on 06/07/2024.
//

import Foundation

final class AddItemsVM: Identifiable, ObservableObject {
    @Published var newItem : String = ""
    @Published var newCategory : String = ""
    @Published var newNumber : Int = 0
    @Published var newStore: ListModel.StoreName
    @Published var isPresented: Bool

    init(newItem: String, newCategory: String, newNumber: Int, newStore: ListModel.StoreName, isPresented: Bool) {
        self.newItem = newItem
        self.newCategory = newCategory
        self.newNumber = newNumber
        self.newStore = newStore
        self.isPresented = isPresented
    }
}
