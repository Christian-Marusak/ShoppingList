//
//  ShoppingProduct.swift
//  ShoppingList
//
//  Created by Christian Marušák on 22/11/2023.
//

import SwiftUI

struct ShoppingProduct: View {
    @State var isBought : Bool
    var value : String
    var product : String
    var category: String
    var number: Int
    var rectangleHeight: CGFloat = 60
    var store: ShoppingList.StoreName
    var categories: ShoppingList.Categories
    var backroundColor : Bool = false
    
    
    var body: some View {
                HStack(alignment: .center, content: {
                    Toggle(isOn: $isBought, label: {
                        Image(systemName: isBought ? "checkmark.circle.fill" : "checkmark.circle" )
                    }).toggleStyle(.button)
                        .onChange(of: isBought) { oldValue, newValue in
                            print("current status is \(newValue), old status is \(oldValue)")
                        }
                        .padding(.leading, -10)
                    Spacer()
                    Text(product)
                        .bold()
                        .font(.system(size: 15))
//                        .frame(width: 150,height: 30,alignment: .center)
                    Spacer()
                    Text(String(number))
                        .frame(alignment: .center)
                        .font(.system(size: 15))
                        Text(String(value))
                            .frame(alignment: .center)
                            .font(.system(size: 15))
//                            .padding(.trailing, 30)
                    })
    }
    private func textColorForStore(store: ShoppingList.StoreName) -> Color {
        switch store {
    default:
        return Color.black
        }
    }

}

#Preview {
    ShoppingProduct(isBought: true, value: "kg", product: "Plnotučný jogurt ", category: "Mliečne výrobky", number: 3, store: .Billa, categories: .bakery)
}
