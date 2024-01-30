//
//  EditItemView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/01/2024.
//

import SwiftUI

struct EditItemView: View {
    @State var itemName: String
    @State var itemCategory: ShoppingList.Categories
    @State var itemNumber: Int
    @State var itemShop: ShoppingList.StoreName
    
    
    
    var body: some View {
        Text(itemName)
        
    }
}

#Preview {
    EditItemView(itemName: "Syr", itemCategory: .bakery, itemNumber: 9, itemShop: .Biedronka)
}
