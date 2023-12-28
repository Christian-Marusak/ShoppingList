//
//  SettingsRowView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 13/12/2023.
//

import SwiftUI

struct SettingsRowView: View {
    
    var image : String
    var title: String
    var tintColor: Color
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: image)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    SettingsRowView(image: "gear", title: "Title", tintColor: Color(.systemGray))
}
