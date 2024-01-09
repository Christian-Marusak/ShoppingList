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
        
//        RoundedRectangle(cornerRadius: 15)
////            .stroke(Color.black, lineWidth: 3)
//            .fill(ShoppingList.gradientForStore(store: store))
//            .frame(height: rectangleHeight)
//            .overlay {
                HStack(alignment: .center, content: {
                    Toggle(isOn: $isBought, label: {
                        Image(systemName: isBought ? "checkmark.circle.fill" : "checkmark.circle" )
                    }).toggleStyle(.button)
                        .onChange(of: isBought) { oldValue, newValue in
                            print("current status is \(newValue), old status is \(oldValue)")
                        }
                    Text(product)
                        .bold()
                        .font(.system(size: 15))
                    Text(String(number))
                        .foregroundColor(textColorForStore(store: store))
                        .frame(alignment: .center)
                        .font(.system(size: 15))
                        Text(String(value))
                            .foregroundColor(textColorForStore(store: store))
                            .frame(alignment: .center)
                            .font(.system(size: 15))
                    })
                
//            }
    }
    private func textColorForStore(store: ShoppingList.StoreName) -> Color {
        switch store {
//        case .Tesco:
//            return Color.black
//        case .none:
//            return Color.white
//        case .Billa:
//            return Color.white
//        case .Malina:
//            return Color.black
//        case .Lidl:
//            return Color.white
//        case .Coop:
//            return Color.black
//        case .Biedronka:
//            return Color.white
    default:
        return Color.black
        }
    }

}

#Preview {
    ShoppingProduct(isBought: true, value: "kg", product: "Plnotučný jogurt", category: "Mliečne výrobky", number: 3, store: .Billa, categories: .bakery)
}
