//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//

import SwiftUI


@main
struct ShoppingListApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView(selectedCategory: ShoppingList.Categories(rawValue: "") ?? .bakery)
            HoldForMoreView()
        }
    }
}
