//
//  ContentView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//
import SwiftUI
import UIKit

struct ContentView: View {
    
    
    //MARK: State Variables
    @EnvironmentObject var myList : ShoppingViewModel
    @Environment(\.editMode) private var editMode
    
    @State var isPresentedAdd = false
    @State var isPresentedEdit = false
    @State var isPresentingCategorySelector : Bool = false
    @State var selectedCategory: ShoppingList.Categories = .bakery
    @State var isOrdered : Bool = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    func sortItemsBasedOnSection(item : ShoppingList, section: String) -> ShoppingList {
        
            
        return ShoppingList
    }
    
    
    //MARK: Main body / List
    
    var body: some View {
        
        
        
        NavigationView (content: {
            List {
                if isOrdered {
                    ForEach(myList.myShopping) { item in
                        ShoppingProduct(
                            isBought: item.isBought,
                            unit: item.unit.rawValue,
                            product: item.category.rawValue,
                            number: item.number)
                        
                        .swipeActions(edge: .leading, allowsFullSwipe: true){
                            EditItemView(itemName: item.item, itemCategory: item.category, itemNumber: Int(item.number), itemShop: item.store, itemUnit: item.unit, isPresented: $isPresentedEdit)
                        }
                    }
                    .onDelete(perform: myList.Delete)
                    .onMove(perform: myList.Move)
                } else {
                    ForEach(myList.generateSectionNamesFromGroups(myList.groupItemsByCategory(myList.myShopping)), id: \.self) { sectionName in
                        Section(sectionName){
//                            ForEach(myList.myShopping.map{$0.category == sectionName}){item in
//                                Text(item.item)
//                            Text(myList.myShopping.map{$0.category.rawValue == sectionName)
                                
//                            }
                            Text(sectionName)
                            
                        }
                    }
                
                }
            }.onAppear(perform: {
                print(myList.myShopping.map{$0.category.rawValue == "bakery"})
            })
            .navigationTitle("Shoppie")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
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
                        //                        myList.getItems()
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding(.leading, 50)
                    
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        myList.DeleteItems()
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
                        
                        
                        
            .onChange(of: myList.myShopping, { oldValue, newValue in
                //            print("Changed and saved")
                myList.saveShoppingList()
            })
                .onAppear {
                    myList.loadShoppingList()
                    //            print("Showing and loading")
                }
            .onDisappear {
                //            print("Disaperaing and saveing")
                myList.saveShoppingList()
            }
            .padding(.top, -10)
                        Button("Test") {
        }
                        
                        })
        .sheet(isPresented: $isPresentedEdit, content: {
            ForEach(myList.myShopping){ item in
                EditItemView(itemName: item.item, itemCategory: item.category, itemNumber: Int(item.number), itemShop: item.store, itemUnit: item.unit, isPresented: $isPresentedEdit)
            }
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
