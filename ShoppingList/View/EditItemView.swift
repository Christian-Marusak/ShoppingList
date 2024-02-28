//
//  EditItemView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/01/2024.
//

import SwiftUI

struct EditItemView: View {
    
    @EnvironmentObject var myList : ShoppingViewModel
    
    @State var itemName: String
    @State var itemCategory: ShoppingList.Categories
    @State var itemNumber: Int
    @State var itemShop: ShoppingList.StoreName
    @State var itemUnit: ShoppingList.Unit
    @Binding var isPresented: Bool
    
    
    
    var body: some View {
//        Spacer(minLength: 300)
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 20, content: {
            Text("What will be your new item?").padding(.top)
                .font(.headline)
            TextField("Item name", text: $itemName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onAppear(perform: {
                    
                })
            HStack {
                Text("Choose category").bold()
                Picker("Category", selection: $itemCategory) {
                    ForEach(ShoppingList.Categories.allCases, id: \.self) { category in
                        Text(ShoppingList.getCategoriesAsString(for: category))
                    }.onChange(of: itemCategory, { oldValue, newValue in
                        ShoppingList.saveToUserDefaults(key: C.lastUsedCategory, value: newValue)
                    })
                    .onAppear {
                        itemCategory = ShoppingList.readFromUserDefaults(key: C.lastUsedCategory, defaultValue: .beverages)
                    }
                }.pickerStyle(.menu)
            }
            
            HStack{
                TextField("Edit number of items", value: $itemNumber, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
                Picker("", selection: $itemUnit) {
                    ForEach(ShoppingList.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }.onChange(of: itemUnit, { oldValue, newValue in
                        print(itemUnit)
                        ShoppingList.saveToUserDefaults(key: C.lastUsedUnit, value: newValue)
                    })
                    .onAppear {
                        itemUnit = ShoppingList.readFromUserDefaults(key: C.lastUsedUnit, defaultValue: .pcs)
                    }
                }.pickerStyle(.wheel)
            }.frame(width: 250,height: 100)
            //                }
            HStack {
                Text("Choose shop").bold()
                Picker("where do you buy it", selection: $itemShop) {
                    ForEach(ShoppingList.StoreName.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }.onChange(of: itemShop, { oldValue, newValue in
                        ShoppingList.saveToUserDefaults(key: C.lastUsedShop, value: newValue)
                        print(itemShop)
                    })
                    .onAppear {
                        // Call the setup function when the view appears
                        itemShop = ShoppingList.readFromUserDefaults(key: C.lastUsedShop, defaultValue: .none)
                    }
                }.pickerStyle(.automatic)
            }
            Button(action: saveButtonPressed , label: {
                Capsule()
                    .frame( width: 200,height: 40)
                    .foregroundStyle(.blue)
                    .overlay {
                        HStack{
                            Image(systemName: "cart.fill")
                                .foregroundStyle(.white)
                                .padding(.leading)
                            Text("Save")
                                .foregroundStyle(.white)
                                .padding(.trailing)
                        }}
            })
//            Spacer(minLength: 300)
        })
    }
    
    
    func saveButtonPressed() {
        
        isPresented.toggle()
    }
}

#Preview {
    EditItemView(itemName: "Syr", itemCategory: .bakery, itemNumber: 9, itemShop: .Biedronka, itemUnit: .kg, isPresented: .constant(false))
        .environmentObject(ShoppingViewModel())
}
