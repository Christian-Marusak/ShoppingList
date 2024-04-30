//
//  ContentView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//
import SwiftUI
import UIKit
import FirebaseCore



struct ContentView: View {
    
    
    // MARK: - State Variables
    @EnvironmentObject var myList: ShoppingViewModel
    @Environment(\.editMode) private var editMode
    
    
    @State var itemName: String = "Name"
    @State var itemNumber: Int = 88
    @State var itemCategory: Categories = .bakery
    @State var itemUnit: Item.Unit = .pcs
    
    
    
    @State var selectedItemFromList: Item?
    @State var isPresentedAdd = false
    @State var isPresentedEdit = false
    @State var isPresentingCategorySelector: Bool = false
    @State var selectedCategory: Categories = .bakery
    @State var isOrdered: Bool = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    // MARK: - Main body / List
    
    var body: some View {
        NavigationView(content: {
            List {
                list
            }
            .padding(.top, 10)
            .navigationTitle("Shoppie")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isOrdered.toggle()
                    } label: {
                        Image(systemName: isOrdered ? "chart.bar.doc.horizontal.fill" : "chart.bar.doc.horizontal")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Add item") {
                        isPresentedAdd.toggle()
                        //                        myList.getMockDataItems()
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding(.leading, 50)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        myList.deleteItems()
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(Color.red)
                            .padding(.bottom, 4)
                    }
                    .padding(.trailing, 50)
                }
            }
            
            
            
            .onChange(of: myList.myShopping, { _, _ in
                // Save shopping list
            })
            .onAppear {
                // load shopping list
            }
            .padding(.top, -10)
            Button("Test") {
            }
            
        })
        .sheet(item: $selectedItemFromList,
               content: { item in
            EditItemView(
                myList: _myList,
                itemName: $itemName,
                itemCategory: $itemCategory,
                itemNumber: $itemNumber,
                itemShop: item.store,
                itemUnit: itemUnit,
                isPresented: $isPresentedEdit
            )
            .presentationDetents([.medium])
            .presentationCornerRadius(20)
        })
        
        
        .sheet(isPresented: $isPresentedAdd, content: {
            AddItems(isPresentedAdd: $isPresentedAdd)
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
            
        })
    }
    
}


#Preview {
    ContentView()
        .environmentObject(ShoppingViewModel())
}





extension ContentView {
    var list: some View {
        ForEach(myList.shoppingList) { typeOfFood in
            
            Section {
                ForEach(typeOfFood.items) { item in
                    if typeOfFood.category == item.category {
                        ShoppingProduct(
                            isBought: item.isBought,
                            unit: item.unit.rawValue,
                            product: item.item,
                            number: item.number)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Delete", role: .destructive) {
                                withAnimation {
                                    myList.deleteItem(typeOfFood: typeOfFood, item: item)
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                //                                myList.updateList(item: item)
                                //                                self.selectedItemFromList = item
                            }
                        }
                    }
                }
            } header: {
                Text(typeOfFood.category.rawValue)
            }
        }
    }
}

extension ContentView {
   
}
