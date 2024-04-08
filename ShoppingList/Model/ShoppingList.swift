//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

struct ShoppingList: Equatable, Codable, Identifiable, Hashable {
    var id: String
    var item: String
    var category: Categories
    var number: Double
    var value: String
    var store: StoreName
    var isBought: Bool
    var unit: Unit
    
    init(
        id: String = UUID().uuidString,
        item: String,
        category: Categories,
        number: Double,
        value: String = String(),
        store: StoreName,
        isBought: Bool = Bool(),
        unit: Unit
    ) {
        self.id = id
        self.item = item
        self.category = category
        self.number = number
        self.value = value
        self.store = store
        self.isBought = isBought
        self.unit = unit
    }
    
    func updateCompletion() -> ShoppingList {
        return ShoppingList(
            id: id,
            item: item,
            category: category,
            number: number,
            store: store,
            isBought: !isBought,
            unit: unit
        )
    }
    
    enum Unit: String, CaseIterable, Codable {
        case pcs, kg, mg, g, dkg, ml, l
    }
    
    enum StoreName: String, CaseIterable, Codable {
        case billa, tesco, lidl, biedronka, coop, malina, none
    }
    
    enum Categories: String, CaseIterable, Codable {
        case cereals
        case fish
        case seafood
        case eggs
        case eggProducts
        case fatsAndOils
        case sugarsAndSweets
        case beverages
        case herbsAndSpices
        case toiletries
        case other
        case fruits
        case vegetables
        case meat
        case meatProducts
        case milk
        case dairyProducts
        case bakery
    }

    static func getCategoriesAsString (for category: Categories) -> String {
        switch category {
        case .cereals: return "Obilniny"
        case .fish: return "Ryby"
        case .seafood: return "Morské plody"
        case .eggs: return "Vajcia"
        case .eggProducts: return "Výrobky z vajec"
        case .fatsAndOils: return "Tuky a oleje"
        case .sugarsAndSweets: return "Cukry a sladkosti"
        case .beverages: return "Nápoje"
        case .herbsAndSpices: return "Korenie a bylinky"
        case .toiletries: return "Drogéria"
        case .other: return "Iné"
        case .fruits: return "Ovocie"
        case .vegetables: return "Zelenina"
        case .meat: return "Mäso"
        case .meatProducts: return "Mäsové výrobky"
        case .milk: return "Mlieko"
        case .dairyProducts: return "Mliečne výrobky"
        case .bakery: return "Pečivo"
        }
    }
    
    func getColorForFood(groceries: Categories) -> Color {
        switch groceries {
        case .cereals: return Color.blue
        case .fish: return Color.green
        case .seafood: return Color.blue
        case .eggs: return Color.yellow
        case .eggProducts: return Color.yellow
        case .fatsAndOils: return Color.gray
        case .sugarsAndSweets: return Color.pink
        case .beverages: return Color.orange
        case .herbsAndSpices: return Color.green
        case .toiletries: return Color.purple
        case .other: return Color.black
        case .fruits: return Color.red
        case .vegetables: return Color.green
        case .meat: return Color.red
        case .meatProducts: return Color.red
        case .milk: return Color.white
        case .dairyProducts: return Color.white
        case .bakery: return Color.yellow
        }
    }
    
    static func gradientForStore(store: StoreName) -> LinearGradient {
        switch store {
        default: return LinearGradient(
            colors: [
                Color.blue,
                Color.blue,
                Color.blue
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        }
    }
    
    static func stringForUnit(unit: Unit) -> String {
        return unit.rawValue
    }
    
    static func stringForStore(store: StoreName) -> String {
        return store.rawValue
    }
    static func readFromUserDefaults<T: Codable>(key: String, defaultValue: T) -> T {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let savedValue = try? JSONDecoder().decode(T.self, from: savedData) {
            return savedValue
        } else {
            return defaultValue
        }
    }
    
    static func saveToUserDefaults<T: Codable>(key: String, value: T) {
        if let encodedData = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
}
