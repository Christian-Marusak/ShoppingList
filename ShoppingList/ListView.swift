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
        HStack{
            Button{
                viewModel.isPresentingCategorySelector.toggle()
            } label:{
                Image(systemName: "list.bullet")
            }.buttonStyle(.borderedProminent)
            Button {
                viewModel.isHidden.toggle()
            } label:{
                Image(systemName: viewModel.isHidden ? "eye.slash" : "eye").animation(.interactiveSpring, value: viewModel.isHidden)
            }.buttonStyle(.borderedProminent)
            Button {
                
            } label:{
                Image(systemName: "building")
            }.buttonStyle(.borderedProminent)
            
        }
        NavigationStack {
            List(viewModel.shopModel.data) { list in
                ShoppingProduct(product: list.item, category: list.category, number: list.number)
            }
            .listStyle(.plain)
        }.sheet(isPresented: $viewModel.isPresented, content: {
            AddItems()
        })
        Button("Add item") {
            viewModel.isPresented.toggle()
        }.buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .animation(.interactiveSpring, value: viewModel.isPresented)
    }
}
#Preview {
    ContentView(viewModel: ListViewVM(isPresentingCategorySelector: false, selectedCategory: "Kategory"))
}
