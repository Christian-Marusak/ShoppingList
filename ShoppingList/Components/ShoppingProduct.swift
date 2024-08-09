//
//  ShoppingProduct.swift
//  ShoppingList
//
//  Created by Christian Marušák on 22/11/2023.
//

import SwiftUI

struct ShoppingProduct: View {
    
    let item: ListModel
    var rectangleHeight: CGFloat = 60
    var backroundColor : Bool = false
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(item.bought == true ? .red : .blue)
            .overlay {
                HStack{
                    Text(item.item)
                        .foregroundStyle(.white)
                        .bold()
                    Spacer()
                    Text(item.category)
                        .foregroundStyle(.white)
                    Spacer()
                    Text(String(item.number))
                        .foregroundStyle(.white)
                }
                .padding([.leading,.trailing])
            }
            .frame(height: 60)
    }
    
}

#Preview(traits: .sizeThatFitsLayout) {
    ShoppingProduct(item: ListModel(item: "Item", category: "category", number: 2, store: .Billa, bought: false))
}
