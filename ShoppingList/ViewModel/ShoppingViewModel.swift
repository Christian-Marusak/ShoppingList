//
//  ShoppingViewModel.swift
//  ShoppingList
//
//  Created by Christián on 14/02/2024.
//

import Foundation
class ShoppingViewModel: ObservableObject {
    
    @Published var myShopping: [ShoppingList] = []
    @Published var boughtItems: [ShoppingList] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [ShoppingList(
            item: "Jogurt",
            category: .milk,
            number: 2.5,
            store: .lidl,
            isBought: false,
            unit: .kg),
                        ShoppingList(
                            item: "Rozok",
                            category: .bakery,
                            number: 15.0,
                            store: .billa,
                            isBought: true,
                            unit: .pcs
                        ),
                        ShoppingList(
                            item: "Olej",
                            category: .fatsAndOils,
                            number: 2.5,
                            store: .biedronka,
                            isBought: true,
                            unit: .l
                        )
        ]
        myShopping.append(contentsOf: newItems)
    }
    func deleteItems() {
        myShopping.removeAll()
    }
    
    func delete(offsets: IndexSet) {
        myShopping.remove(atOffsets: offsets)
    }
    func move(from: IndexSet, to: Int) {
        myShopping.move(fromOffsets: from, toOffset: to)
    }
    func saveShoppingList() {
        do {
            let encodedData = try JSONEncoder().encode(myShopping)
            print(encodedData)
            UserDefaults.standard.set(encodedData, forKey: Const.userDefaultsKey)
        } catch {
            print("Error encoding shopping list: \(error.localizedDescription)")
        }
    }
    
    // Add a function to load myShopping from UserDefaults
    func loadShoppingList() {
        if let encodedData = UserDefaults.standard.data(forKey: Const.userDefaultsKey) {
            do {
                myShopping = try JSONDecoder().decode([ShoppingList].self, from: encodedData)
            } catch {
                print("Error decoding shopping list: \(error.localizedDescription)")
            }
        }
    }
    
    func addItems(
        newItem: String,
        newCategory: ShoppingList.Categories,
        newNumber: Double,
        store: ShoppingList.StoreName,
        isBought: Bool,
        unit: ShoppingList.Unit
    ) {
        let newItem = ShoppingList(
            item: newItem,
            category: newCategory,
            number: newNumber,
            store: store,
            isBought: false,
            unit: unit
        )
        myShopping.append(newItem)
    }
    
    func updateList (item: ShoppingList) {
        
        if let index = myShopping.firstIndex(where: { $0.id == item.id }) {
            myShopping[index] = item.updateCompletion()
        }
        
    }
    
    func disableItem(item: ShoppingList) {
        if let index = myShopping.firstIndex(where: { $0.id == item.id }) {
            myShopping[index] = item.updateCompletion()
        }
        boughtItems.append(item)
        
        
    }
    
    
    
    
}
