//
//  ListModel.swift
//  ShoppingList
//
//  Created by Christián on 02/07/2024.
//

import Foundation
struct ListModel: Identifiable, Hashable {
    var id = UUID()
    var item = String()
    var category = String()
    var number = Int()
    var store: StoreName
    var bought: Bool
    

    
    enum StoreName: String, CaseIterable, Codable{
        case Billa, Tesco, Lidl, Biedronka, Coop, Malina, none
    }
    
    static func stringForStore(store: StoreName) -> String {
        return store.rawValue
    }
}

@Observable
final class ShoppingMockData {
    
//    @Published var data: [ListModel]
    var data = [
        ListModel(item: "Jablka", category: "Ovocie", number: 4,store: .Billa, bought: false),
        ListModel(item: "Hrozno", category: "Ovocie", number: 5,store: .Billa, bought: false),
        ListModel(item: "Banany", category: "Zelenina", number: 3,store: .Coop, bought: false),
        ListModel(item: "Banany", category: "Zelenina", number: 3,store: .Coop, bought: false),
        ListModel(item: "Hrušky", category: "Oriesky", number: 6,store: .Malina, bought: false),
        ListModel(item: "Kiwi", category: "Maso", number: 2,store: .Tesco, bought: false),
        ListModel(item: "Jahody", category: "Ovocie", number: 7,store: .Lidl, bought: false),
        ListModel(item: "Hrušky", category: "Oriesky", number: 6,store: .Coop, bought: false),
        ListModel(item: "Kiwi", category: "Maso", number: 2,store: .Biedronka, bought: false),
        ListModel(item: "Jahody", category: "Ovocie", number: 7,store: .Lidl, bought: false),
        ListModel(item: "Maliny", category: "Ovocie", number: 4,store: .Tesco, bought: false),
    ]
    
//    init() {
//        data = localData
//    }
    
    func addData(_ list: ListModel) {
        data.append(list)
        print(list)
        print("________________________")
        print(list.item)
        print("________________________")
    }
    
    func remove(at offsets: IndexSet) {
        let itemsToRemove = offsets.map {data[$0]}
        data.remove(atOffsets: offsets)
        print("----------------------------")
        print("Deleting item \(itemsToRemove)")
        print("----------------------------")
    }
}
