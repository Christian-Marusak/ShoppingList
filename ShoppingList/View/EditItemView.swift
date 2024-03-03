//
//  EditItemView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/01/2024.
//

import SwiftUI

struct EditItemView: View {
    
    @EnvironmentObject var myList : ShoppingViewModel
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused : Bool
    @Binding var itemName: String
    @Binding var itemCategory: ShoppingList.Categories
    @Binding var itemNumber: Int
    var secondItemNumber: Int {
        let strNumber = String(itemNumber)
        let decimalIndex = strNumber.firstIndex(of: ".")!
        let decimalPartStr = strNumber[decimalIndex...]
        let decimalPart = Int(decimalPartStr)!
        return decimalPart
    }
    @State var itemShop: ShoppingList.StoreName
    @State var itemUnit: ShoppingList.Unit
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 20, content: {
            Text("How to do you want to change item?").padding(.top)
                .font(.headline)
            TextField("Item name", text: $itemName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .focused($isFocused)
                .onAppear(perform: {
                    isFocused.toggle()
                })
            HStack {
                Text("Change category").bold()
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
                Picker("", selection: $itemNumber) {
                    ForEach(0...100, id: \.self){item in
                        Text("\(item)")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80)
//                Text(",")
//                Picker("", selection: secondItemNumber) {
//                    ForEach(0...100, id: \.self){item in
//                        Text("\(item)")
//                    }
//                }
                .pickerStyle(.wheel)
                .frame(width: 80)
                
                Picker("", selection: $itemUnit) {
                    ForEach(ShoppingList.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }.onChange(of: itemUnit, { oldValue, newValue in
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
        })
    }
    
    
    func saveButtonPressed() {
        myList.updateList(item: ShoppingList(item: itemName, category: itemCategory, store: itemShop, unit: itemUnit))
        dismiss()
    }
}

#Preview {
    EditItemView(itemName: .constant("Syr"), itemCategory: .constant(.bakery), itemNumber: .constant(9), itemShop: .Biedronka, itemUnit: .kg, isPresented: .constant(false))
        .environmentObject(ShoppingViewModel())
}
