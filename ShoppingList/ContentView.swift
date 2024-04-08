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
    @State var itemCategory: ShoppingList.Categories = .bakery
    @State var itemUnit: ShoppingList.Unit = .pcs
    
    
    
    @State var selectedItemFromList: ShoppingList?
    @State var isPresentedAdd = false
    @State var isPresentedEdit = false
    @State var isPresentingCategorySelector: Bool = false
    @State var selectedCategory: ShoppingList.Categories = .bakery
    @State var isOrdered: Bool = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    func createJSON() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(myList.myShopping)
            print(String(data: encodedData, encoding: .utf8)!)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func filterBySection(list: [ShoppingList], section: String) -> [ShoppingList] {
        return list.filter { $0.category.rawValue == section }
    }
    
    func groupItemsByCategory(_ items: [ShoppingList]) -> [ShoppingList.Categories: [ShoppingList]] {
        var groupedItems: [ShoppingList.Categories: [ShoppingList]] = [:]
        
        for item in items {
            if var categoryItems = groupedItems[item.category] {
                categoryItems.append(item)
                groupedItems[item.category] = categoryItems
            } else {
                groupedItems[item.category] = [item]
            }
        }
        
        return groupedItems
    }
    
    func generateSectionNamesFromGroups(_ groupedItems: [ShoppingList.Categories: [ShoppingList]]) -> [String] {
        return groupedItems.keys.map { $0.rawValue.capitalized }
    }
    
    // MARK: - Main body / List
    
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(myList.myShopping) { item in
                    ShoppingProduct(
                        isBought: item.isBought,
                        unit: item.unit.rawValue,
                        product: item.item,
                        number: item.number)
                    .onTapGesture {
                        withAnimation {
                            myList.updateList(item: item)
                            self.selectedItemFromList = item
                        }
                    }
                    
                }
                .onDelete(perform: myList.delete)
                .onMove(perform: myList.move)
            }
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
                        createJSON()
//                        myList.DeleteItems()
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
