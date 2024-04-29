//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

enum Categories: String, CaseIterable, Codable {
    case cereals = "Obilniny"
    case fish = "Ryby"
    case seafood = "Morské plody"
    case eggs = "Vajcia"
    case eggProducts = "Výrobky z vajec"
    case fatsAndOils = "Tuky a oleje"
    case sugarsAndSweets = "Cukry a sladkosti"
    case beverages = "Nápoje"
    case herbsAndSpices = "Korenie a bylinky"
    case toiletries = "Drogéria"
    case other = "Iné"
    case fruits = "Ovocie"
    case vegetables = "Zelenina"
    case meat = "Mäso"
    case meatProducts = "Mäsové výrobky"
    case milk = "Mlieko"
    case dairyProducts = "Mliečne výrobky"
    case bakery = "Pečivo"
}

struct Item: Equatable, Codable, Identifiable, Hashable {
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
    
    func updateCompletion() -> Item {
        return Item(
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
