//
//  ListViewVM.swift
//  ShoppingList
//
//  Created by Christián on 04/07/2024.
//

import Foundation
import SwiftUI

@Observable
class ListViewVM: ObservableObject {
    var shopModel = ShoppingMockData()
    var isPresented : Bool
    var isPresentingCategorySelector : Bool = false
    var selectedCategory: String
    var isHidden = false
    
    init(shopModel: ShoppingMockData, isPresented: Bool = false, isPresentingCategorySelector: Bool, selectedCategory: String, isHidden: Bool = false) {
        self.shopModel = shopModel
        self.isPresented = isPresented
        self.isPresentingCategorySelector = isPresentingCategorySelector
        self.selectedCategory = selectedCategory
        self.isHidden = isHidden
    }
}
