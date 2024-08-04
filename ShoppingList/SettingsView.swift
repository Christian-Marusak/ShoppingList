//
//  SettingsView.swift
//  ShoppingList
//
//  Created by Christián on 04/08/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack{
            Text("Settings")
            
            SettingsRowView(image: "pencil", title: "Pencil", tintColor: .purple)
            SettingsRowView(image: "pencil", title: "Pencil", tintColor: .purple)
            SettingsRowView(image: "pencil", title: "Pencil", tintColor: .purple)
        }
    }
}

#Preview {
    SettingsView()
}
