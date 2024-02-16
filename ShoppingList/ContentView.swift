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
    
    @State var isPresented = false
    @State var isPresentingCategorySelector : Bool = false
    @State var selectedCategory: ShoppingList.Categories = .bakery
    @State var isOrdered : Bool = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
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
            //            print("Changed from \(oldValue) to \(newValue)")
        }
        .onAppear(perform: {
            isOrdered = ShoppingList.readFromUserDefaults(key: C.isOrdered, defaultValue: false)
        })
        
        List {
            if isOrdered {
                ForEach(myList.myShopping) {section in
                    Section(section.category.rawValue) {
                        ForEach(myList.myShopping){ item in
                            ShoppingProduct(isBought: item.isBought,
                                            unit: item.unit.rawValue,
                                            product: item.category.rawValue,
                                            number: item.number
                            )
                        }
                    }
                }.onDelete(perform: myList.Delete)
                
            } else {
                ForEach(myList.myShopping) { item in
                    ShoppingProduct(
                        isBought: item.isBought,
                        unit: item.unit.rawValue,
                        product: item.category.rawValue,
                        number: item.number)
                }
                .onDelete(perform: myList.Delete)
                .onMove(perform: myList.Move)
            }
        }
        
        .listStyle(.insetGrouped)
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
        //
        .sheet(isPresented: $isPresented, content: {
            //            AddItems(isPresented: $isPresented, itemsInputCompletion: itemsInputCompletion)
            //                .presentationDetents([.medium])
            //                .presentationCornerRadius(20)
            
        })
        HStack {
            Button("Add item") {
                //            isPresented.toggle()
                myList.getItems()
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .animation(.interactiveSpring, value: isPresented)
            
            
            //MARK: Just for testing purposes
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
            .padding(.leading)
            //MARK: Just for testing purposes
            
            
        }
    }
    
}


#Preview {
    ContentView()
        .environmentObject(ShoppingViewModel())
}
