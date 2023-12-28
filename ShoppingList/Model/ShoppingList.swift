//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

struct ShoppingList : Identifiable, Equatable, Codable {
    var id = UUID()
    var item = String()
    var category = String()
    var number = Int()
    var store: StoreName
    
    enum StoreName: String, CaseIterable, Codable {
        case Billa, Tesco, Lidl, Biedronka, Coop, Malina, none
    }
    
    static func gradientForStore(store: StoreName) -> LinearGradient {
        switch store {
        case .Tesco: return LinearGradient(colors: [Color.blue, Color.white, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .Billa: return LinearGradient(colors: [Color.yellow, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .Malina: return LinearGradient(colors: [Color.white, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .Lidl: return LinearGradient(colors: [Color.yellow, Color.blue, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .Coop: return LinearGradient(colors: [Color.white, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .Biedronka: return LinearGradient(colors: [Color.yellow, Color.red], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .none: return LinearGradient(colors: [Color.blue, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    static func stringForStore(store: StoreName) -> String {
        return store.rawValue
    }
}
