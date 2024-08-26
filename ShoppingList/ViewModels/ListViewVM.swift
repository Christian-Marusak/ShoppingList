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
    var isHidden: Bool = false
    
    func loadData() {
        data = ShoppingMockData.shared.loadData()
    }
    func removeData(id: UUID) {
        if let index = data.firstIndex(where: {$0.id == id}) {
            ShoppingMockData.shared.remove(at: IndexSet(integer: index))
            data.remove(atOffsets: IndexSet(integer: index))
        }
    }
    
    func addData(data: ListModel){
        ShoppingMockData.shared.addData(data)
        self.data.append(data)
    }
    
    func changeBought(id: UUID) {
        if let index = data.firstIndex(where: {$0.id == id}) {
            let myIndexSet = IndexSet(integer: index)
            ShoppingMockData.shared.changeBought(at: myIndexSet)
            for myNumber in myIndexSet {
                data[myNumber].bought.toggle()
            }
        }
    }
    
}
