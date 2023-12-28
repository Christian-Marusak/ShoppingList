//
//  ContentView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//
import SwiftUI

struct ContentView: View {
    
    @State var myShopping : [ShoppingList] = [
        ShoppingList(item: "Jablka", category: "Ovocie", number: 4,store: .Billa),
        ShoppingList(item: "Hrozno", category: "Ovocie", number: 5,store: .Billa),
        ShoppingList(item: "Banany", category: "Zelenina", number: 3,store: .Coop),
        ShoppingList(item: "Banany", category: "Zelenina", number: 3,store: .Coop),
        ShoppingList(item: "Hrušky", category: "Oriesky", number: 6,store: .Malina),
        ShoppingList(item: "Kiwi", category: "Maso", number: 2,store: .Tesco),
        ShoppingList(item: "Jahody", category: "Ovocie", number: 7,store: .Lidl),
        ShoppingList(item: "Hrušky", category: "Oriesky", number: 6,store: .Coop),
        ShoppingList(item: "Kiwi", category: "Maso", number: 2,store: .Biedronka),
        ShoppingList(item: "Jahody", category: "Ovocie", number: 7,store: .Lidl),
        ShoppingList(item: "Maliny", category: "Ovocie", number: 4,store: .Tesco),
        ShoppingList(item: "Mlieko", category: "Mlieko", number: 2, store: .Tesco)
    ]
    
    @State var isPresented = false
    @State var isPresentingCategorySelector : Bool = false
    @State var selectedCategory: String
    @State var currentDragOffset : CGFloat = 0
    @State var isHidden = false
    
    func itemsInputCompletion (newItems: ShoppingList) {
        myShopping.append(newItems)
    }
    func sortCategories(myList: [ShoppingList], selectedCategory: String) -> [ShoppingList] {
        var sortedList = myList
        
//MARK: Sort the list based on the selected category
        
        sortedList.sort { item1, item2 in
            if item1.category == selectedCategory {
                return true
            } else if item2.category == selectedCategory {
                return false
            } else {
                return item1.category < item2.category
            }
        }
        return sortedList
    }

    
//MARK: Main content / List of items
    
    var body: some View {
            Text("Shopping List").font(.largeTitle).bold()
            HStack{
                Button{
                    isPresentingCategorySelector.toggle()
                } label:{
                    Image(systemName: "list.bullet")
                }.buttonStyle(.borderedProminent)
                Button {
                    isHidden.toggle()
                } label:{
                    Image(systemName: isHidden ? "eye.slash" : "eye").animation(.interactiveSpring, value: isHidden)
                }.buttonStyle(.borderedProminent)
                Button {
                    
                } label:{
                    Image(systemName: "building")
                }.buttonStyle(.borderedProminent)
                
            }
            List {
                ForEach(sortCategories(myList: myShopping, selectedCategory: selectedCategory )) { index in
                    ShoppingProduct(isHidden: $isHidden, product: index.item, category: index.category, number: index.number, store: index.store )
                }
                .onDelete(perform: { indexSet in
                    myShopping.remove(atOffsets: indexSet)
                    print("Deleting items at indices: \(indexSet)")
                    print("Updated yourItems: \(ShoppingList.self)")
                })
            }.environment(\.defaultMinListRowHeight, 50)
                .listStyle(.plain)
                .sheet(isPresented: $isPresented, content: {
                    AddItems(itemsInputCompletion: itemsInputCompletion, freeList: $myShopping, isPresented: $isPresented)
                })
                .sheet(isPresented: $isPresentingCategorySelector) {
                    CategorySelectorView(categories: Set(myShopping.map { $0.category }), isPresentingCategory: $isPresentingCategorySelector, selectedCategory: $selectedCategory)
                        .presentationDetents([.height(250)])
                        .presentationDragIndicator(.hidden)
                }
            Button("Add item") {
                isPresented.toggle()
            }.buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .animation(.interactiveSpring, value: isPresented)

    }
}



#Preview {
    ContentView(selectedCategory: "")
}
