//
//  SettingsView.swift
//  ShoppingList
//
//  Created by Christián on 04/08/2024.
//

import SwiftUI

struct SettingsView: View {
    var userProfileName: String = "Joseph"
    var userProfileSurname: String = "Sarah"
    @State var viewShops: Bool = false
    
    var body: some View {
       VStack {
            Spacer()
            HStack(alignment: .bottom, content: {
                Text(userProfileSurname)
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                Text(userProfileName)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            })
            Form(content: {
                Section("View settings") {
                    Toggle("View shops", isOn: $viewShops)
                    Toggle("Languge", isOn: $viewShops)
                    Toggle("Preview of shops", isOn: $viewShops)
                }
            })
        }
    }
}

#Preview {
    SettingsView()
}
