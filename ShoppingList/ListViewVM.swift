//
//  ListViewVM.swift
//  ShoppingList
//
//  Created by Christián on 04/07/2024.
//

import Foundation
import SwiftUI

@Observable
class ListViewVM {
    
    var isPresented: Bool = false
    var data: [ListModel] = []
    
    func loadData() {
        data = ShoppingMockData.shared.loadData()
    }
    func removeData(index: IndexSet) {
        ShoppingMockData.shared.remove(at: index)
        data.remove(atOffsets: index)
    }
    
    func addData(data: ListModel){
        ShoppingMockData.shared.addData(data)
        self.data.append(data)
    }
    
    func changeBought(itemToChange: ListModel){
        
    }
}
