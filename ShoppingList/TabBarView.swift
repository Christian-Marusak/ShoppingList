//
//  TabBarView.swift
//  ShoppingList
//
//  Created by Christián on 04/08/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ContentView(viewModel: .init(isPresentingCategorySelector: false, selectedCategory: "Category"))
            .tabItem {
                Label(
                    title: { Text("List") },
                    icon: { Image(systemName: "list.clipboard") }
                )
                
            }
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
    TabBarView()
}
