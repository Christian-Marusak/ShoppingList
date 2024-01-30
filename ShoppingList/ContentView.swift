//
//  ContentView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//
import SwiftUI

struct ContentView: View {
    
    @State var myShopping : [ShoppingList] = [
//        ShoppingList(item: "Jablka", category: .fruits, number: 4, value: "kg", store: .Billa, isBought: false),
//        ShoppingList(item: "Hrozno", category: .fruits, number: 5, value: "kg", store: .Billa, isBought: false),
//        ShoppingList(item: "Banany", category: .fruits, number: 3, value: "kg", store: .Coop, isBought: false),
//        ShoppingList(item: "Hrušky", category: .fruits, number: 6, value: "kg", store: .Malina, isBought: false),
//        ShoppingList(item: "Kiwi", category: .fruits, number: 2, value: "kg", store: .Tesco, isBought: false),
//        ShoppingList(item: "Jahody", category: .fruits, number: 7, value: "kg", store: .Lidl, isBought: false),
//        ShoppingList(item: "Maliny", category: .fruits, number: 4, value: "kg", store: .Tesco, isBought: false),
//        ShoppingList(item: "Mlieko", category: .milk, number: 2, value: "l", store: .Tesco, isBought: false),
//        ShoppingList(item: "Rajčiny", category: .vegetables, number: 3, value: "kg", store: .Coop, isBought: false),
//        ShoppingList(item: "Cibuľa", category: .vegetables, number: 2, value: "kg", store: .Biedronka, isBought: false),
//        ShoppingList(item: "Baklažán", category: .vegetables, number: 1, value: "kg", store: .Lidl, isBought: false),
//        ShoppingList(item: "Kuracie prsia", category: .meat, number: 2, value: "kg", store: .Biedronka, isBought: false),
//        ShoppingList(item: "Hovädzie mäso", category: .meat, number: 3, value: "kg", store: .Tesco, isBought: false),
//        ShoppingList(item: "Klobása", category: .meatProducts, number: 2, value: "kg", store: .Lidl, isBought: false),
//        ShoppingList(item: "Plnotučný jogurt", category: .dairyProducts, number: 1, value: "l", store: .Coop, isBought: false),
//        ShoppingList(item: "Tvaroh", category: .dairyProducts, number: 5, value: "kg", store: .Malina, isBought: false),
//        ShoppingList(item: "Hrozienka", category: .cereals, number: 3, value: "kg", store: .Tesco, isBought: false),
//        ShoppingList(item: "Celozrnný chlieb", category: .bakery, number: 1, value: "ks", store: .Lidl, isBought: false),
//        ShoppingList(item: "Losos", category: .fish, number: 5, value: "kg", store: .Billa, isBought: false),
//        ShoppingList(item: "Mušle", category: .seafood, number: 1, value: "kg", store: .Tesco, isBought: false),
//        ShoppingList(item: "Vajcia", category: .eggs, number: 12, value: "ks", store: .Coop, isBought: false),
//        ShoppingList(item: "Vajcový šalát", category: .eggProducts, number: 2, value: "kg", store: .Biedronka, isBought: false),
//        ShoppingList(item: "Maslo", category: .fatsAndOils, number: 25, value: "kg", store: .Malina, isBought: false),
//        ShoppingList(item: "Olivový olej", category: .fatsAndOils, number: 5, value: "l", store: .Tesco, isBought: false),
//        ShoppingList(item: "Čokoláda", category: .sugarsAndSweets, number: 2, value: "ks", store: .Lidl, isBought: false),
//        ShoppingList(item: "Med", category: .sugarsAndSweets, number: 3, value: "kg", store: .Billa, isBought: false),
//        ShoppingList(item: "Zelený čaj", category: .beverages, number: 1, value: "ks.", store: .Coop, isBought: false),
//        ShoppingList(item: "Korenie", category: .herbsAndSpices, number: 1, value: "ks", store: .Biedronka, isBought: false),
//        ShoppingList(item: "Petržlen", category: .herbsAndSpices, number: 1, value: "kg", store: .Tesco, isBought: false)
    ]
    
    @State var isPresented = false
    @State var isPresentingCategorySelector : Bool = false
    @State var selectedCategory: ShoppingList.Categories
    @State var value = "ml"
    @State var isOrdered : Bool = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    //MARK: Functions
    
    func itemsInputCompletion (newItems: ShoppingList) {
        myShopping.append(newItems)
    }
    
    // Function to get the category header for a section
    func getCategoryHeader(from section: [ShoppingList]) -> AnyView {
        if let firstItem = section.first {
            return AnyView(Text(ShoppingList.getCategoriesAsString(for: firstItem.category)))
        } else {
            return AnyView(EmptyView())
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
                myShopping = try JSONDecoder().decode([ShoppingList].self, from: encodedData)
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
        let sortedList = myShopping.sorted { item1, item2 in
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
                    ForEach(groupedSection, id: \.id) { item in
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
                let sortedList = sortAndGroupList(by: selectedCategory).flatMap { $0 }
                
                // Get the UUIDs of the items to be deleted
                let uuidsToDelete = indexSet.map { sortedList[$0].id }
                
                // Update myShopping by filtering out items with matching UUIDs
                myShopping = myShopping.filter { !uuidsToDelete.contains($0.id) }
                
                print("Deleting items with UUIDs: \(uuidsToDelete)")
            })
                        } else {
                            ForEach(myShopping, id: \.id) { item in
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
                                        }

                                    }
                            }.onDelete(perform: { indexSet in
                                myShopping.remove(atOffsets: indexSet)
                            })
                        }
        }
        .onChange(of: myShopping, { oldValue, newValue in
            print("Changed and saved")
            saveShoppingList()
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
            AddItems(properAmountUnit: value, isPresented: $isPresented, itemsInputCompletion: itemsInputCompletion, freeList: $myShopping)
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
