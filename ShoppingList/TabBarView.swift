//
//  TabBarView.swift
//  ShoppingList
//
//  Created by Christián on 04/08/2024.
//

import SwiftUI

struct TabBarView: View {
    var shopingData: ShoppingMockData
    var body: some View {
        TabView {
            ContentView(viewModel: .init(shopModel: ShoppingMockData(), isPresentingCategorySelector: false, selectedCategory: "Category"))
            .tabItem {
                Label(
                    title: { Text("List") },
                    icon: { Image(systemName: "list.clipboard") }
                )
                
            }.badge(shopingData.data.count)
            SettingsView()
                .tabItem {
                    Label(
                        title: { Text("Settings") },
                        icon: { Image(systemName: "gear") }
                    )
                }
        }
    }
}

#Preview {
    TabBarView(shopingData: ShoppingMockData())
}
