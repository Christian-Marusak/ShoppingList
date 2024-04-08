//
//  InputView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 12/12/2023.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color.gray)
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text).font(.system(size: 14))
            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Adress", placeholder: "name@example.com")
}
