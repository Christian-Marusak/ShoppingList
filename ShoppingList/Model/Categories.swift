//
//  Categories.swift
//  ShoppingList
//
//  Created by Tomáš Duchoslav on 30.04.2024.
//

import Foundation

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
