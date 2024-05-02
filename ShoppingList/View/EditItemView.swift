//
//  EditItemView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/01/2024.
//

import SwiftUI

struct EditItemView: View {
    
    @EnvironmentObject var myList: ShoppingViewModel
    @ObservedObject var editModel = EditItemViewModel()
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
               spacing: 20,
               content: {
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
                    ForEach(Categories.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }.onChange(of: itemCategory, { _, newValue in
                        Item.saveToUserDefaults(key: Const.lastUsedCategory, value: newValue)
                    })
                    .onAppear {
                        itemCategory = Item.readFromUserDefaults(
                            key: Const.lastUsedCategory,
                            defaultValue: .beverages
                        )
                    }
                }.pickerStyle(.menu)
            }
            
            HStack {
                Picker("", selection: $itemNumber) {
                    ForEach(0...100, id: \.self) { item in
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
                    ForEach(Item.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }.onChange(of: itemUnit, { _, newValue in
                        Item.saveToUserDefaults(key: Const.lastUsedUnit, value: newValue)
                    })
                    .onAppear {
                        itemUnit = Item.readFromUserDefaults(key: Const.lastUsedUnit, defaultValue: .pcs)
                    }
                }.pickerStyle(.wheel)
            }.frame(width: 250, height: 100)
            //                }
            HStack {
                Text("Choose shop").bold()
                Picker("where do you buy it", selection: $itemShop) {
                    ForEach(Item.StoreName.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }.onChange(of: itemShop, { _, newValue in
                        Item.saveToUserDefaults(key: Const.lastUsedShop, value: newValue)
                        print(itemShop)
                    })
                    .onAppear {
                        // Call the setup function when the view appears
                        itemShop = Item.readFromUserDefaults(
                            key: Const.lastUsedShop,
                            defaultValue: .none
                        )
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
                            Text("Save")
                                .foregroundStyle(.white)
                                .padding(.trailing)
                        }}
            })
        })
    }
    
    
    func saveButtonPressed() {
        myList.updateList(
            item: Item(
                item: itemName,
                category: itemCategory,
                number: Double(
                    itemNumber
                ),
                store: itemShop,
                unit: itemUnit
            )
        )
        dismiss()
    }
}

#Preview {
    EditItemView(
        itemName: .constant(
            "Syr"
        ),
        itemCategory: .constant(
            .bakery
        ),
        itemNumber: .constant(
            9
        ),
        itemShop: .biedronka,
        itemUnit: .kg,
        isPresented: .constant(
            false
        )
    )
        .environmentObject(ShoppingViewModel())
}
