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
    @State private var properAmountCategory: String = "weight"
    @State private var properAmountUnit: String = ""
    
    @State var selectedShop : ShoppingList.StoreName = .none
    var itemsInputCompletion : (ShoppingList) -> Void
    var freeList: Binding<[ShoppingList]>
    @Binding var isPresented: Bool
    @State var allCategories = ["weight","volume"]
    @State var weight = ["kg","g","mg","dkg"]
    @State var volume = ["ml", "l","dkg"]
    @State var properAmount : Bool = false
    
    var catgoriesOfFoods = [
        "Ovocie a zelenina",
        "Mäso a mäsová výrobky",
        "Mlieko a mliečne výrobky",
        "Obilniny a pečivo",
        "Ryby a morské plody",
        "Vajcia a výrobky z vajec",
        "Tuky a oleje",
        "Cukry a sladkosti",
        "Nápoje",
        "Korenie a bylinky"
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
                TextField("Category name", text: $newCategory)
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
                Toggle(isOn: $properAmount.animation(.interactiveSpring)) {
                    Text("Enter proper amount")
                }
                VStack {
                    if properAmount {
                        Picker("", selection: $properAmountCategory) {
                            ForEach(allCategories, id: \.self) { category in
                                Text(category)
                            }
                        }.pickerStyle(.segmented)
                        
                        if properAmountCategory == "weight" {
                            
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
                                Text("\(newNumber)")
                                
                                Picker("", selection: $properAmountUnit) {
                                    ForEach(volume, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    } else {
                        HStack{
                            Stepper("Enter number of pieces", value: $newNumber)
                            Text("\(newNumber)")
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
                let list = ShoppingList(item: newItem, category: newCategory, number: newNumber, store: selectedShop)
                itemsInputCompletion(list)
                newItem = ""
                newNumber = 0
                newCategory = ""
                isPresented = false
                
            }
        }
    }
}

#Preview {
    AddItems(selectedShop: .Coop, itemsInputCompletion: { _ in }, freeList: .constant(([])), isPresented: .constant(false))
}
