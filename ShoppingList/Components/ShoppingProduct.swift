//
//  ShoppingProduct.swift
//  ShoppingList
//
//  Created by Christian Marušák on 22/11/2023.
//

import SwiftUI

struct ShoppingProduct: View {
    var product : String = "Produkt"
    var category: String = "Kategoria"
    var number: Int = 2
    var rectangleHeight: CGFloat = 60
    var backroundColor : Bool = false
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .overlay {
                HStack{
                    Text(product)
                        .foregroundStyle(.white)
                        .bold()
                    Spacer()
                    Text(category)
                        .foregroundStyle(.white)
                    Spacer()
                    Text(String(number))
                        .foregroundStyle(.white)
                }
                .padding([.leading,.trailing])
            }
            .frame(height: 60)
    }
    
}

#Preview {
    ShoppingProduct()
}
