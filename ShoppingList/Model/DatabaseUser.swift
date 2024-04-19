//
//  DatabaseUser.swift
//  ShoppingList
//
//  Created by Christián on 10/04/2024.
//

import Foundation

struct DatabaseUser: Codable {
    let id: String
    let email: String
    let isPremium: Bool
    let name: String
    let dateCreated: Date
}
