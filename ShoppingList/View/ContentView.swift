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
    @ObservedObject var contentModel = ContentViewModel()
    
    
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
                        contentModel.isOrdered.toggle()
                    } label: {
                        Image(systemName: contentModel.isOrdered ? "chart.bar.doc.horizontal.fill" : "chart.bar.doc.horizontal")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Add item") {
                        contentModel.isPresentedAdd.toggle()
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
        .sheet(item: contentModel.$selectedItemFromList,
               content: { item in
            EditItemView(
                myList: _myList,
                itemName: contentModel.$itemName,
                itemCategory: contentModel.$itemCategory,
                itemNumber: contentModel.$itemNumber,
                itemShop: item.store,
                itemUnit: contentModel.itemUnit,
                isPresented: contentModel.$isPresentedEdit
            )
            .presentationDetents([.medium])
            .presentationCornerRadius(20)
        })
        .sheet(isPresented: contentModel.$isPresentedAdd, content: {
            AddItems(isPresentedAdd: contentModel.$isPresentedAdd)
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
