//
//  ShoppingViewModel.swift
//  ShoppingList
//
//  Created by Christián on 14/02/2024.
//
import FirebaseFirestore
import Foundation

class ShoppingViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var kategorie: [Kategorie] = [] 
    
    @Published var myShopping: [Item] = []
    @Published var boughtItems: [Item] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [Item(
            item: "Jogurt",
            category: .milk,
            number: 2.5,
            store: .lidl,
            isBought: false,
            unit: .kg),
                        Item(
                            item: "Rozok",
                            category: .bakery,
                            number: 15.0,
                            store: .billa,
                            isBought: true,
                            unit: .pcs
                        ),
                        Item(
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
        myShopping.removeAll()
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
    
    func addItems(
        newItem: String,
        newCategory: Categories,
        newNumber: Double,
        store: Item.StoreName,
        isBought: Bool,
        unit: Item.Unit
    ) {
        let newItem = Item(
            item: newItem,
            category: newCategory,
            number: newNumber,
            store: store,
            isBought: false,
            unit: unit
        )
        myShopping.append(newItem)
    }
    
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
