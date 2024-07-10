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
    

    
    enum StoreName: String, CaseIterable, Codable{
        case Billa, Tesco, Lidl, Biedronka, Coop, Malina, none
    }
    
    static func stringForStore(store: StoreName) -> String {
        return store.rawValue
    }
}

//extension ListModel {
//    init(id: UUID = UUID(), item: String = String(), category: String = String(), number: Int = Int(), store: StoreName) {
//        self.id = id
//        self.item = item
//        self.category = category
//        self.number = number
//        self.store = store
//    }
//}

final class ShoppingMockData: ObservableObject {
    
    @Published var data: [ListModel]
    private var localData = [
        ListModel(item: "Jablka", category: "Ovocie", number: 4,store: .Billa),
        ListModel(item: "Hrozno", category: "Ovocie", number: 5,store: .Billa),
        ListModel(item: "Banany", category: "Zelenina", number: 3,store: .Coop),
        ListModel(item: "Banany", category: "Zelenina", number: 3,store: .Coop),
        ListModel(item: "Hrušky", category: "Oriesky", number: 6,store: .Malina),
        ListModel(item: "Kiwi", category: "Maso", number: 2,store: .Tesco),
        ListModel(item: "Jahody", category: "Ovocie", number: 7,store: .Lidl),
        ListModel(item: "Hrušky", category: "Oriesky", number: 6,store: .Coop),
        ListModel(item: "Kiwi", category: "Maso", number: 2,store: .Biedronka),
        ListModel(item: "Jahody", category: "Ovocie", number: 7,store: .Lidl),
        ListModel(item: "Maliny", category: "Ovocie", number: 4,store: .Tesco),
        ListModel(item: "Mlieko", category: "Mlieko", number: 2, store: .Tesco)
    ]
    
    init() {
        data = localData
    }
    
    func addData(_ list: ListModel) {
        data.append(list)
        print(data)
    }
}
