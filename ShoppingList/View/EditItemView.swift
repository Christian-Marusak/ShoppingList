//
//  EditItemView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/01/2024.
//

import SwiftUI

struct EditItemView: View {
    
    @EnvironmentObject var myList: ShoppingViewModel
    @ObservedObject var editModel: EditItemViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
               spacing: 20,
               content: {
            Text("How to do you want to change item?").padding(.top)
                .font(.headline)
            TextField("Item name", text: $editModel.itemName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .focused($editModel.isFocused)
                .onAppear(perform: {
                    editModel.isFocused.toggle()
                })
            HStack {
                Text("Change category").bold()
                Picker("Category", selection: editModel.$itemCategory) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }.onChange(of: editModel.itemCategory, { _, newValue in
                        Item.saveToUserDefaults(key: Const.lastUsedCategory, value: newValue)
                    })
                    .onAppear {
                        editModel.itemCategory = Item.readFromUserDefaults(
                            key: Const.lastUsedCategory,
                            defaultValue: .beverages
                        )
                    }
                }.pickerStyle(.menu)
            }
            
            HStack {
                Picker("", selection: editModel.$itemNumber) {
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
                
                Picker("", selection: editModel.$itemUnit) {
                    ForEach(Item.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }.onChange(of: editModel.itemUnit, { _, newValue in
                        Item.saveToUserDefaults(key: Const.lastUsedUnit, value: newValue)
                    })
                    .onAppear {
                        editModel.itemUnit = Item.readFromUserDefaults(key: Const.lastUsedUnit, defaultValue: .pcs)
                    }
                }.pickerStyle(.wheel)
            }.frame(width: 250, height: 100)
            //                }
            HStack {
                Text("Choose shop").bold()
                Picker("where do you buy it", selection: editModel.$itemShop) {
                    ForEach(Item.StoreName.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }.onChange(of: editModel.itemShop, { _, newValue in
                        Item.saveToUserDefaults(key: Const.lastUsedShop, value: newValue)
                        print(editModel.itemShop)
                    })
                    .onAppear {
                        // Call the setup function when the view appears
                        editModel.itemShop = Item.readFromUserDefaults(
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
                item: editModel.itemName,
                category: editModel.itemCategory,
                number: Double(
                    editModel.itemNumber
                ),
                store: editModel.itemShop,
                unit: editModel.itemUnit
            )
        )
        dismiss()
    }
}

#Preview {
    EditItemView()
    
        .environmentObject(ShoppingViewModel())
}
