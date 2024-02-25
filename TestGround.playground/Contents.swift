import UIKit
import SwiftUI


struct ShoppingCart {
    let category : String
    let item: String
    let Unit : String
    let number : Int
}

let cart = [
    ShoppingCart(category: "beverages", item: "Coca-Cola", Unit: "pcs", number: 2),
    ShoppingCart(category: "dairy", item: "Milk", Unit: "l", number: 2),
    ShoppingCart(category: "fruits", item: "Apples", Unit: "kg", number: 2),
    ShoppingCart(category: "vegetables", item: "Potatoes", Unit: "kg", number: 3),
    ShoppingCart(category: "bakery", item: "Bread", Unit: "pcs", number: 1),
    ShoppingCart(category: "beverages", item: "Chicken", Unit: "kg", number: 2),
    ShoppingCart(category: "snacks", item: "Chips", Unit: "bag", number: 1),
    ShoppingCart(category: "beverages", item: "Pizza", Unit: "pcs", number: 2),
    ShoppingCart(category: "condiments", item: "Ketchup", Unit: "pcs", number: 1),
    ShoppingCart(category: "cleaning", item: "Dish soap", Unit: "pcs", number: 1),
]


let lookedForWord = "beverages"

let filteredItems = cart.filter{$0.category == lookedForWord}
for item in filteredItems {
    print(item.item)
}

