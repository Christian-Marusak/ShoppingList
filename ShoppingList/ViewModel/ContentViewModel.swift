//
//  ContentViewModel.swift
//  ShoppingList
//
//  Created by Christián on 01/05/2024.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @State var itemName: String = "Name"
    @State var itemNumber: Int = 88
    @State var itemCategory: Categories = .bakery
    @State var itemUnit: Item.Unit = .pcs
    @State var selectedItemFromList: Item?
    @State var isPresentedAdd = false
    @State var isPresentedEdit = false
    @State var isPresentingCategorySelector: Bool = false
    @State var selectedCategory: Categories = .bakery
    @State var isOrdered: Bool = false
}
