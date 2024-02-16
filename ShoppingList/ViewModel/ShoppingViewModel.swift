//
//  ShoppingViewModel.swift
//  ShoppingList
//
//  Created by Christián on 14/02/2024.
//

import Foundation
class ShoppingViewModel: ObservableObject {
    
    @Published var myShopping: [ShoppingList] = []
    
    init() {
        getItems()
    }
    
    
    func getItems() {
        let newItems = [ShoppingList(item: "Jogurt", category: .milk, number: 2.5, store: .Lidl, isBought: false, unit: .kg),ShoppingList(item: "Rozok", category: .bakery, number: 15.0, store: .Billa, isBought: true, unit: .pcs),ShoppingList(item: "Olej", category: .fatsAndOils, number: 2.5, store: .Biedronka, isBought: true, unit: .l)]
        myShopping.append(contentsOf: newItems)
    }
    func DeleteItems() {
        myShopping.removeAll()
    }
    
    func Delete(offsets: IndexSet){
        myShopping.remove(atOffsets: offsets)
    }
    func Move(from: IndexSet, to: Int) {
        myShopping.move(fromOffsets: from, toOffset: to)
    }
    func saveShoppingList() {
        do {
            let encodedData = try JSONEncoder().encode(myShopping)
            print(encodedData)
            UserDefaults.standard.set(encodedData, forKey: C.userDefaultsKey)
        } catch {
            print("Error encoding shopping list: \(error.localizedDescription)")
        }
    }
    
    // Add a function to load myShopping from UserDefaults
    func loadShoppingList() {
        if let encodedData = UserDefaults.standard.data(forKey: C.userDefaultsKey) {
            do {
                myShopping = try JSONDecoder().decode([ShoppingList].self, from: encodedData)
            } catch {
                print("Error decoding shopping list: \(error.localizedDescription)")
            }
        }
    }
    
    func addItems(newItem : String, newCategory : ShoppingList.Categories, newNumber : Double, store: ShoppingList.StoreName, isBought: Bool, unit: ShoppingList.Unit) {
        let newItem = ShoppingList(item: newItem, category: newCategory, number: newNumber, store: store , isBought: false, unit: unit)
        myShopping.append(newItem)
    }

}
