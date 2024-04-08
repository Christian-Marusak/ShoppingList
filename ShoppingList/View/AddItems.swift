//
//  AddItems.swift
//  ShoppingList
//
//  Created by Christian Marušák on 21/11/2023.
//

import SwiftUI

struct AddItems: View {
    
    @EnvironmentObject var myList: ShoppingViewModel
    @State private var newItem: String = ""
    @State private var newNumber: Int = 0
    @State private var newSecondNumber: Int = 0
    @FocusState private var isFocused: Bool


    @Binding var isPresentedAdd: Bool
    @State var selectedCategory: ShoppingList.Categories = .beverages
    @State var selectedShop: ShoppingList.StoreName = .none
    @State var selectedUnit: ShoppingList.Unit = .kg
    
    var completedNumber: Double {
        print(newNumber, newSecondNumber)
        return Double("\(newNumber).\(newSecondNumber)") ?? 0.28
    }
    
    var body: some View {
        Spacer(minLength: 300)
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
               spacing: 20,
               content: {
            Text("What will be your new item?").padding(.top)
                .font(.headline)
            TextField("Item name", text: $newItem)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .focused($isFocused)
                .onAppear(perform: {
                    isFocused.toggle()
                })
            HStack {
                Text("Choose category").bold()
                Picker("Category", selection: $selectedCategory) {
                    ForEach(ShoppingList.Categories.allCases, id: \.self) { category in
                        Text(ShoppingList.getCategoriesAsString(for: category))
                    }.onChange(of: selectedCategory, { _, newValue in
                        ShoppingList.saveToUserDefaults(key: Const.lastUsedCategory, value: newValue)
                    })
                    .onAppear {
                        selectedCategory = ShoppingList.readFromUserDefaults(
                            key: Const.lastUsedCategory,
                            defaultValue: .beverages
                        )
                    }
                }.pickerStyle(.menu)
            }
            
            HStack {
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
                
                
                Picker("", selection: $selectedUnit) {
                    ForEach(ShoppingList.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }.onChange(of: selectedUnit, { _, newValue in
                        print(selectedUnit)
                        ShoppingList.saveToUserDefaults(key: Const.lastUsedUnit, value: newValue)
                    })
                    .onAppear {
                        selectedUnit = ShoppingList.readFromUserDefaults(key: Const.lastUsedUnit, defaultValue: .pcs)
                    }
                }.pickerStyle(.wheel)
            }.frame(width: 250, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            //                }
            HStack {
                Text("Choose shop").bold()
                Picker("where do you buy it", selection: $selectedShop) {
                    ForEach(ShoppingList.StoreName.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }.onChange(of: selectedShop, { _, newValue in
                        ShoppingList.saveToUserDefaults(key: Const.lastUsedShop, value: newValue)
                        print(selectedShop)
                    })
                    .onAppear {
                        // Call the setup function when the view appears
                        selectedShop = ShoppingList.readFromUserDefaults(key: Const.lastUsedShop, defaultValue: .none)
                    }
                }.pickerStyle(.automatic)
            }
            Button(action: saveButtonPressed, label: {
                Capsule()
                    .frame( width: 200, height: 40)
                    .foregroundStyle(.blue)
                    .overlay {
                        HStack {
                            Image(systemName: "cart.fill")
                                .foregroundStyle(.white)
                                .padding(.leading)
                            Text("Add to shopping")
                                .foregroundStyle(.white)
                                .padding(.trailing)
                        }}
            })
            Spacer(minLength: 300)
        })
    }
    func saveButtonPressed() {
        myList.addItems(
            newItem: newItem,
            newCategory: selectedCategory,
            newNumber: completedNumber,
            store: selectedShop,
            isBought: false,
            unit: selectedUnit
        )
        isPresentedAdd.toggle()
        
    }
    
    
    
}


#Preview {
    AddItems(isPresentedAdd: .constant(false), selectedShop: .coop)
        .environmentObject(ShoppingViewModel())
}
