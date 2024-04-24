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
    
    func createJSON() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(myShopping)
            print(String(data: encodedData, encoding: .utf8)!)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func filterBySection(list: [ShoppingList], section: String) -> [ShoppingList] {
        return list.filter { $0.category.rawValue == section }
    }
    
    func groupItemsByCategory(_ items: [ShoppingList]) -> [ShoppingList.Categories: [ShoppingList]] {
        var groupedItems: [ShoppingList.Categories: [ShoppingList]] = [:]
        
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
    
    func generateSectionNamesFromGroups(_ groupedItems: [ShoppingList.Categories: [ShoppingList]]) -> [String] {
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
