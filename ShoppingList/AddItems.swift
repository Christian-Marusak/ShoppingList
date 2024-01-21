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
    @State var selectedUnit : ShoppingList.Unit = .kg
    var itemsInputCompletion : (ShoppingList) -> Void
    var freeList: Binding<[ShoppingList]>
    
    var completedNumber : Double {
        print(newNumber , newSecondNumber)
        return Double("\(newNumber).\(newSecondNumber)") ?? 0.28
    }
    
    func addItems() {
        let list = ShoppingList(item: newItem, category: selectedCategory, number: completedNumber, value: selectedUnit.rawValue, store: selectedShop)
        itemsInputCompletion(list)
        newItem = ""
        newNumber = 0
        newCategory = ""
        properAmountUnit = ""
        isPresented = false
    }
    
    var body: some View {
        Spacer(minLength: 300)
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 20, content: {
            Text("What will be your new item?").padding(.top)
                .font(.headline)
            //            Form(content:  {
            //                Section("Enter item and category") {
            TextField("Item name", text: $newItem)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            HStack {
                Text("Choose category").bold()
                Picker("Category", selection: $selectedCategory) {
                    ForEach(ShoppingList.Categories.allCases, id: \.self) { category in
                        Text(ShoppingList.getCategoriesAsString(for: category))
                    }.onChange(of: selectedCategory, { oldValue, newValue in
                        print(selectedCategory)
                        ShoppingList.saveToUserDefaults(key: C.lastUsedCategory, value: newValue)
                    })
                    .onAppear {
                        selectedCategory = ShoppingList.readFromUserDefaults(key: C.lastUsedCategory, defaultValue: .beverages)
                    }
                }.pickerStyle(.menu)
            }
            //                }
            //                Section("Choose number of items") {
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
                
                
                Picker("", selection: $selectedUnit) {
                    ForEach(ShoppingList.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }.onChange(of: selectedUnit, { oldValue, newValue in
                        print(selectedUnit)
                        ShoppingList.saveToUserDefaults(key: C.lastUsedUnit, value: newValue)
                    })
                    .onAppear {
                        selectedUnit = ShoppingList.readFromUserDefaults(key: C.lastUsedUnit, defaultValue: .pcs)
                    }
                }.pickerStyle(.wheel)
            }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            //                }
            HStack {
                Text("Choose shop").bold()
                Picker("where do you buy it", selection: $selectedShop) {
                    ForEach(ShoppingList.StoreName.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }.onChange(of: selectedShop, { oldValue, newValue in
                        ShoppingList.saveToUserDefaults(key: C.lastUsedShop, value: newValue)
                        print(selectedShop)
                    })
                    .onAppear {
                        // Call the setup function when the view appears
                        selectedShop = ShoppingList.readFromUserDefaults(key: C.lastUsedShop, defaultValue: .none)
                    }
                }.pickerStyle(.automatic)
            }
            Button(action: {
                addItems()
            }, label: {
                Capsule()
                    .frame( width: 200,height: 40)
                    .foregroundStyle(.blue)
                    .overlay {
                        HStack{
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
}


#Preview {
    AddItems(isPresented: .constant(false), selectedShop: .Coop, itemsInputCompletion: { _ in }, freeList: .constant(([])))
}
