//
//  EditItemView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/01/2024.
//

import SwiftUI

struct EditItemView: View {
    @Binding var itemName: String
    @Binding var itemCategory: ShoppingList.Categories
    @Binding var itemNumber: Int
    @Binding var itemShop: ShoppingList.StoreName
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EditItemView(itemName: .constant("Name"), itemCategory: .constant(.beverages), itemNumber: .constant(3), itemShop: .constant(.Lidl))
}
