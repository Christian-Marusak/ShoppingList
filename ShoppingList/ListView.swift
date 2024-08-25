//
//  ListView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//
import SwiftUI

struct ContentView: View {
    
    var viewModel: ListViewVM = .init()
    
    
    //MARK: Main content / List of items
    
    var body: some View {

        NavigationStack {
            List(viewModel.data) { list in
                ShoppingProduct(item: list)
                    .onTapGesture(count: 2, perform: {
//                        viewModel.changeBought(id: list.id)
                        viewModel.changeBought(id: list.id)
                    })
                    .swipeActions(edge: .leading, content: {
                        Button(role: .destructive,action: {
                            viewModel.removeData(id: list.id)
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
                        print("Buttton")
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
                        print("Buttton")
                    } label:{
                        Image(systemName: "eye")
//                        Image(systemName: viewModel.isHidden ? "eye.slash" : "eye").animation(.interactiveSpring, value: viewModel.isHidden)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
//                        viewModel.isPresented.toggle()
                        print("Buttton")
                    }label: {
                        Image(systemName: "plus")
                    }.bold()
                }
            })
        }
        .onAppear(perform: {
            viewModel.loadData()
        })
//        .sheet(isPresented: viewModel.isPresented, content: {
//            AddItems()
//        })
        .badge(viewModel.data.count)
    }
}
#Preview {
    ContentView()
}
