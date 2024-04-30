//
//  Category.swift
//  ShoppingList
//
//  Created by Tomáš Duchoslav on 29.04.2024.
//

import Foundation

struct TypeOfFood: Identifiable {
    var id: String = UUID().uuidString
    var items: [Item]
    var category: Categories
}
