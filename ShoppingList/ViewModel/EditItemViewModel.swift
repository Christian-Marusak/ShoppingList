//
//  EditItemViewModel.swift
//  ShoppingList
//
//  Created by Christián on 01/05/2024.
//

import Foundation
import SwiftUI

class EditItemViewModel: ObservableObject {
    
    
    var isFocused: Bool
    var itemName: String
    var itemCategory: Categories
    var itemNumber: Int
    var secondItemNumber: Int {
        let strNumber = String(itemNumber)
        let decimalIndex = strNumber.firstIndex(of: ".")!
        let decimalPartStr = strNumber[decimalIndex...]
        let decimalPart = Int(decimalPartStr)!
        return decimalPart
    }
    @State var itemShop: Item.StoreName
    @State var itemUnit: Item.Unit
    var isPresented: Bool
    
    
    init(isFocused: Bool, itemName: String, itemCategory: Categories, itemNumber: Int, itemShop: Item.StoreName, itemUnit: Item.Unit, isPresented: Bool) {
        self.isFocused = isFocused
        self.itemName = itemName
        self.itemCategory = itemCategory
        self.itemNumber = itemNumber
        self.itemShop = itemShop
        self.itemUnit = itemUnit
        self.isPresented = isPresented
    }
}
