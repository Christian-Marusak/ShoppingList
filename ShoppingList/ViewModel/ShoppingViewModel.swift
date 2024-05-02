//
//  ShoppingViewModel.swift
//  ShoppingList
//
//  Created by Christián on 14/02/2024.
//

import Foundation
import Firebase

class ShoppingViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var shoppingList: [TypeOfFood] = []
    
    @Published var myShopping: [Item] = []
    @Published var boughtItems: [Item] = []
    
    init() {
        getMockDataItems()
    }
    
    func addItem(
        newItem: String,
        newCategory: Categories,
        newNumber: Double,
        store: Item.StoreName,
        isBought: Bool,
        unit: Item.Unit
    ) {
        let newItem = Item(item: newItem,
                           category: newCategory,
                           number: newNumber,
                           store: store,
                           isBought: false,
                           unit: unit)
        
        let index = self.shoppingList.firstIndex(where: {$0.category == newItem.category})
        
        if !self.shoppingList.contains(where: {$0.category == newItem.category}) {
            let newTypeOfFood = TypeOfFood(items: [newItem], category: newItem.category)
            shoppingList.append(newTypeOfFood)
        } else {
            guard let index = index else {return}
            shoppingList[index].items.append(newItem)
        }
    }
    
    func deleteItem(typeOfFood: TypeOfFood, item: Item) {
        guard let itemIndex = typeOfFood.items.firstIndex(where: {$0.id == item.id}) else {return}
        guard let typeOfFoodIndex = shoppingList.firstIndex(where: {$0.id == typeOfFood.id}) else {return}
        shoppingList[typeOfFoodIndex].items.remove(at: itemIndex)
        if shoppingList[typeOfFoodIndex].items.isEmpty {
            shoppingList.remove(at: typeOfFoodIndex)
        }
    }
    
    func getMockDataItems() {
        let item1 = Item(
            item: "Jogurt",
            category: .milk,
            number: 2.5,
            store: .lidl,
            isBought: false,
            unit: .kg)
        
        let item2 = Item(
            item: "Rozok",
            category: .bakery,
            number: 15.0,
            store: .billa,
            isBought: true,
            unit: .pcs)
        
        let item3 = Item(
            item: "Olej",
            category: .fatsAndOils,
            number: 2.5,
            store: .biedronka,
            isBought: true,
            unit: .l)
        
        let category1 = TypeOfFood(items: [item1], category: item1.category)
        let category2 = TypeOfFood(items: [item2], category: item2.category)
        let category3 = TypeOfFood(items: [item3], category: item3.category)
        
        let shoppingList = [category1, category2, category3]
        
        for typeOfFood in shoppingList {
            if self.shoppingList.contains(where: {$0.category == typeOfFood.category }),
               let index = self.shoppingList.firstIndex(where: {$0.category == typeOfFood.category }) {
                for item in typeOfFood.items {
                    self.shoppingList[index].items.append(item)
                }
            } else {
                self.shoppingList.append(typeOfFood)
            }
        }
    }
    
    func createJSON() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(myShopping)
            print(String(data: encodedData, encoding: .utf8)!)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func filterBySection(list: [Item], section: String) -> [Item] {
        return list.filter { $0.category.rawValue == section }
    }
    
    func groupItemsByCategory(_ items: [Item]) -> [Categories: [Item]] {
        var groupedItems: [Categories: [Item]] = [:]
        
        for item in items {
            if var categoryItems = groupedItems[item.category] {
                categoryItems.append(item)
                groupedItems[item.category] = categoryItems
            } else {
                groupedItems[item.category] = [item]
            }
        }
        
        return groupedItems
    }
    
    func generateSectionNamesFromGroups(_ groupedItems: [Categories: [Item]]) -> [String] {
        return groupedItems.keys.map { $0.rawValue.capitalized }
    }
    
    func deleteItems() {
        shoppingList.removeAll()
    }
    
    func delete(offsets: IndexSet) {
        myShopping.remove(atOffsets: offsets)
    }
    func move(from: IndexSet, to: Int) {
        myShopping.move(fromOffsets: from, toOffset: to)
    }
    
    //    func saveShoppingList() async {
    //        do {
    //            let ref = try await db.collection("lists")
    //          print("Document added with ID: \(ref.documentID)")
    //        } catch {
    //          print("Error adding document: \(error)")
    //        }
    //    }
    
    //    // Add a function to load myShopping from UserDefaults
    //    func loadShoppingList() {
    //
    //    }
    
    func updateList (item: Item) {
        
        if let index = myShopping.firstIndex(where: { $0.id == item.id }) {
            myShopping[index] = item.updateCompletion()
        }
        
    }
    
    func disableItem(item: Item) {
        if let index = myShopping.firstIndex(where: { $0.id == item.id }) {
            myShopping[index] = item.updateCompletion()
        }
        boughtItems.append(item)
        
        
    }
    
    
    
    
}
