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
    @State private var store: String = ""
    @State private var properAmountCategory: String = "volume"
    @State private var properAmountUnit: String = ""
    
    @State var selectedCategory : ShoppingList.Categories = .beverages
    @State var selectedShop : ShoppingList.StoreName = .none
    var itemsInputCompletion : (ShoppingList) -> Void
    var freeList: Binding<[ShoppingList]>
    @Binding var isPresented: Bool
    @State var allCategories = [ "pieces" ,"weight","volume"]
    @State var weight = ["kg","g","mg","dkg"]
    @State var volume = ["ml", "l","dc"]
    @State var properAmount : Bool = false
    
    var catgoriesOfFoods = [
        "Ovocie",
        "Zelenina",
        "Mäso",
        "Mäsové výrobky",
        "Mlieko",
        "Mliečne výrobky",
        "Obilniny",
        "Pečivo",
        "Ryby",
        "Morské plody",
        "Vajcia",
        "Výrobky z vajec",
        "Tuky a oleje",
        "Cukry a sladkosti",
        "Nápoje",
        "Korenie a bylinky",
        "Drogéria",
        "Iné",
    ]
    var filteredCategories: [String] {
        if newCategory.isEmpty {
            return catgoriesOfFoods
        } else {
            return catgoriesOfFoods.filter { $0.localizedCaseInsensitiveContains(newCategory) }
        }
    }
    var body: some View {
        Form {
            Section("Enter item and category") {
                TextField("Item name", text: $newItem)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(ShoppingList.Categories.allCases, id: \.self) { category in
                        Text(ShoppingList.getCategoriesAsString(for: category))
                    }
                }.pickerStyle(.menu)
                if !newCategory.isEmpty {
                    List {
                        ForEach(filteredCategories, id: \.self) {result in
                            NavigationLink(result) {
                                Text(result)
                            }.onTapGesture(perform: {
                                newCategory = result
                            })
                        }
                    }
                    .searchable(text: $newCategory)
                }
                
            }
            Section("Choose number of items") {
                Picker("", selection: $properAmountCategory) {
                    ForEach(allCategories, id: \.self) { category in
                        Text(category)
                    }
                }.pickerStyle(.segmented)
                
                if properAmountCategory == "pieces" {
                    HStack{
                        Stepper("Enter number of pieces", value: $newNumber)
                        Text("\(newNumber)")
                        
                    }
                }
                else if properAmountCategory == "weight" {
                    
                    HStack {
                        Stepper("", value: $newNumber)
                        Text("\(newNumber)")
                        
                        Picker("", selection: $properAmountUnit) {
                            ForEach(weight, id: \.self) { number in
                                Text("\(number)")
                            }
                        }.pickerStyle(.menu)
                    }
                } else if properAmountCategory == "volume" {
                    
                    HStack {
                        Stepper("", value: $newNumber)
                        Spacer()
                        Text("\(newNumber)")
                            .bold()
                        
                        Picker("", selection: $properAmountUnit) {
                            ForEach(volume, id: \.self) { number in
                                Text("\(number)")
                            }
                        }.pickerStyle(.menu)
                    }
                }
            }
            Picker("where do you buy it", selection: $selectedShop) {
                ForEach(ShoppingList.StoreName.allCases, id: \.self) { store in
                    Text(store.rawValue)
                }
            }.pickerStyle(.menu)
        }
        Button("Add items to your shopping list"){
            let list = ShoppingList(item: newItem, category: selectedCategory, number: newNumber, value: properAmountUnit, store: selectedShop)
            itemsInputCompletion(list)
            newItem = ""
            newNumber = 0
            newCategory = ""
            properAmountUnit = ""
            isPresented = false
            
        }
    }
}


#Preview {
    AddItems(selectedShop: .Coop, itemsInputCompletion: { _ in }, freeList: .constant(([])), isPresented: .constant(false))
}
