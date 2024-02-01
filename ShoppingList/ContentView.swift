//
//  ContentView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//
import SwiftUI
import UIKit

struct ContentView: View {
    
    var myShopping : [ShoppingList] = []
    @State var newList = [ShoppingList]()
    @State var isPresented = false
    @State var isPresentingCategorySelector : Bool = false
    @State var selectedCategory: ShoppingList.Categories
    @State var value = "ml"
    @State var isOrdered : Bool = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    //MARK: Functions
    
    func Delete(offsets: IndexSet){
        newList.remove(atOffsets: offsets)
    }
    
    func itemsInputCompletion (newItems: ShoppingList) {
        newList.append(newItems)
    }
    
    // Function to get the category header for a section
    @ViewBuilder func getCategoryHeader(from section: [ShoppingList]) -> some View {
        if let firstItem = section.first {
            Text(ShoppingList.getCategoriesAsString(for: firstItem.category))
        } else {
            EmptyView()
        }
    }
    
    func saveShoppingList() {
        do {
            let encodedData = try JSONEncoder().encode(myShopping)
            print(encodedData)
            UserDefaults.standard.set(encodedData, forKey: C.userDefaultsKey)
        } catch {
            print("Error encoding shopping list: \(error.localizedDescription)")
        }
    }
    
    // Add a function to load myShopping from UserDefaults
    func loadShoppingList() {
        if let encodedData = UserDefaults.standard.data(forKey: C.userDefaultsKey) {
            do {
                newList = try JSONDecoder().decode([ShoppingList].self, from: encodedData)
            } catch {
                print("Error decoding shopping list: \(error.localizedDescription)")
            }
        }
    }
    class AppDelegate: NSObject, UIApplicationDelegate {
        func applicationWillTerminate(_ application: UIApplication) {
            // Save your data when the app is about to terminate
            ContentView( selectedCategory: .bakery).saveShoppingList()
            print("Terminated and saved")
        }
    }
    
    func sortAndGroupList(by selectedCategory: ShoppingList.Categories? = nil) -> [[ShoppingList]] {
        var groupedItems = Dictionary<ShoppingList.Categories, [ShoppingList]>()
        
        // Sort the list alphabetically by category name
        let sortedList = newList.sorted { item1, item2 in
            return item1.category.rawValue < item2.category.rawValue
        }
        
        // Group the sorted list by category
        for item in sortedList {
            let category = item.category
            groupedItems[category, default: []].append(item)
        }
        
        // Convert the dictionary values to an array of arrays
        let groupedArray = groupedItems.values.map { $0 }
        
        return groupedArray
    }
    
    //MARK: Main body / List
    
    var body: some View {
        Text("Shopping List").font(.largeTitle).bold()
            .padding(.top, 5)
        
        Button(action: {
            isOrdered.toggle()
            feedbackGenerator.impactOccurred()
        }, label: {
            Image(systemName: isOrdered ? "chart.bar.doc.horizontal.fill" : "chart.bar.doc.horizontal")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .padding(.bottom)
        }).onChange(of: isOrdered) { oldValue, newValue in
            ShoppingList.saveToUserDefaults(key: C.isOrdered, value: newValue)
            print("Changed from \(oldValue) to \(newValue)")
        }
        .onAppear(perform: {
            isOrdered = ShoppingList.readFromUserDefaults(key: C.isOrdered, defaultValue: false)
            print("Reading from userDefaults and old saved value is \(ShoppingList.readFromUserDefaults(key: C.isOrdered, defaultValue: true))")
        })
        List {
            if isOrdered {
                ForEach(sortAndGroupList(by: selectedCategory), id: \.self) { groupedSection in
                    Section(header: getCategoryHeader(from: groupedSection)) {
                        ForEach(groupedSection) { item in
                            ShoppingProduct(
                                isBought: item.isBought,
                                value: item.value,
                                product: item.item,
                                category: item.category.rawValue,
                                number: item.number,
                                store: item.store,
                                categories: item.category
                            )
                        }
                    }
                }.onDelete(perform: { indexSet in
                    Delete(offsets: indexSet)
                })
            } else {
                ForEach(newList) { item in
                    ShoppingProduct(
                        isBought: item.isBought,
                        value: item.value,
                        product: item.item,
                        category: item.category.rawValue,
                        number: item.number,
                        store: item.store,
                        categories: item.category).swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                print("Item edited")
                            } label: {
                                Image(systemName: "chart.bar.doc.horizontal.fill")
                                    
                            }.tint(.blue)
                            
                        }
                }.onDelete(perform: { indexSet in
                    Delete(offsets: indexSet)
                })
            }
        }
        .onChange(of: myShopping, { oldValue, newValue in
            print("Changed and saved")
            saveShoppingList()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                newList = myShopping
                print(newList)
            }
        })
        .onAppear {
            loadShoppingList()
            print("Showing and loading")
        }
        .onDisappear {
            print("Disaperaing and saveing")
            saveShoppingList()
        }
        .padding(.top, -10)
        //
        .sheet(isPresented: $isPresented, content: {
            AddItems(properAmountUnit: value, isPresented: $isPresented, itemsInputCompletion: itemsInputCompletion, freeList: $newList)
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
        })
        Button("Add item") {
            isPresented.toggle()
        }.buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .animation(.interactiveSpring, value: isPresented)
    }
    
}


#Preview {
    ContentView( selectedCategory: .bakery)
}
