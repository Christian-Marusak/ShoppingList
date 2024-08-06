//
//  ListView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ListViewVM
    
    
    
    //MARK: Main content / List of items
    
    var body: some View {

        NavigationStack {
            List(viewModel.shopModel.data) { list in
                ShoppingProduct(product: list.item, category: list.category, number: list.number)
                    .swipeActions(edge: .leading, content: {
                        Button(role: .destructive,action: {
                            if let index = viewModel.shopModel.data.firstIndex(where: {$0.id == list.id}) {
                                viewModel.shopModel.remove(at: IndexSet(integer: index))
                                print("----------------------------")
                                print("Deleting item \(list.item)")
                                print("----------------------------")
                            }
                        }, label: {
                            Image(systemName: "trash.fill")
                                
                        })
                    })
                    .swipeActions(edge: .trailing) {
                        Button(action: {
                            print("Editing item")
                        }, label: {
                            Image(systemName: "pencil")
                                .tint(.accentColor)
                        })
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Shopping list")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        viewModel.isPresentingCategorySelector.toggle()
                    } label:{
                        Image(systemName: "list.bullet")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //setup view based on where i am going to shop //markets
                    } label:{
                        Image(systemName: "building")
                    }
                }
                
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isHidden.toggle()
                    } label:{
                        Image(systemName: viewModel.isHidden ? "eye.slash" : "eye").animation(.interactiveSpring, value: viewModel.isHidden)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isPresented.toggle()
                    }label: {
                        Image(systemName: "plus")
                    }.bold()
                }
            })
        }
        .sheet(isPresented: $viewModel.isPresented, content: {
            AddItems()
        })
        
    }
}
#Preview {
    ContentView(viewModel: ListViewVM(isPresentingCategorySelector: false, selectedCategory: "Kategory"))
}
