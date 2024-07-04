//
//  ListViewVM.swift
//  ShoppingList
//
//  Created by Christián on 04/07/2024.
//

import Foundation
import SwiftUI

class ListViewVM: ObservableObject {
    @Published var shopModel = ShoppingMockData()
    @Published var isPresented = false
    @Published var isPresentingCategorySelector : Bool = false
    @Published var selectedCategory: String
    @Published var isHidden = false
    
    init(isPresented: Bool = false, isPresentingCategorySelector: Bool, selectedCategory: String, isHidden: Bool = false) {
        self.isPresented = isPresented
        self.isPresentingCategorySelector = isPresentingCategorySelector
        self.selectedCategory = selectedCategory
        self.isHidden = isHidden
    }
    
    func itemsInputCompletion (newItems: ListModel) {
        shopModel.data.append(newItems)
        
    }
    
    
}
