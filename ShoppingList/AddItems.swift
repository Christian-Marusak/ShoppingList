//
//  AddItems.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

struct AddItems: View {
    
    @State private var newItem : String = ""
    @State private var newCategory : String = ""
    @State private var newNumber : Int = 0
    @State private var newSecondNumber : Int = 0
    @State var properAmountUnit: String = ""
    @State var comaNumber: Bool = false
    @Binding var isPresented: Bool
    @State var selectedCategory : ShoppingList.Categories = .beverages
    @State var selectedShop : ShoppingList.StoreName = .none
    var itemsInputCompletion : (ShoppingList) -> Void
    var freeList: Binding<[ShoppingList]>
    
    
    @State var allUnits = ["kg","g","mg","dkg","ml", "l","dcl","pieces"]
    
    var completedNumber : Double {
        print(newNumber , newSecondNumber)
            return Double("\(newNumber).\(newSecondNumber)") ?? 0.28
    }
    
    var body: some View {
        Form(content:  {
            Section("Enter item and category") {
                TextField("Item name", text: $newItem)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(ShoppingList.Categories.allCases, id: \.self) { category in
                        Text(ShoppingList.getCategoriesAsString(for: category))
                    }
                }.pickerStyle(.menu)
            }
            Section("Choose number of items") {
                HStack{
                    Picker("", selection: $newNumber) {
                        ForEach(0...100, id: \.self) { category in
                            Text("\(category)")
                        }
                    }.pickerStyle(.wheel)
                    Text(",")
                        Picker("", selection: $newSecondNumber) {
                            ForEach(0...100, id: \.self) { category in
                                Text("\(category)")
                            }
                        }.pickerStyle(.wheel)
                    
                    
                    Picker("", selection: $properAmountUnit) {
                        ForEach(allUnits, id: \.self) { category in
                            Text(category)
                        }
                    }.pickerStyle(.wheel)
                }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
                Picker("where do you buy it", selection: $selectedShop) {
                    ForEach(ShoppingList.StoreName.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }
                }.pickerStyle(.menu)
            
            Button("Add items to your shopping list"){
                let list = ShoppingList(item: newItem, category: selectedCategory, number: completedNumber, value: properAmountUnit, store: selectedShop)
                itemsInputCompletion(list)
                print(completedNumber)
                newItem = ""
                newNumber = 0
                newCategory = ""
                properAmountUnit = ""
                isPresented = false
                
            }
        }
    )}
}


#Preview {
    AddItems(isPresented: .constant(false), selectedShop: .Coop, itemsInputCompletion: { _ in }, freeList: .constant(([])))
}
