//
//  ShoppingProduct.swift
//  ShoppingList
//
//  Created by Christian Marušák on 22/11/2023.
//

import SwiftUI

struct ShoppingProduct: View {
    @Binding var isHidden : Bool
    var product : String
    var category: String
    var number: Int
    var rectangleHeight: CGFloat = 60
    var store: ShoppingList.StoreName
    var backroundColor : Bool = false
    
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.blue, lineWidth: 3)
            .fill(ShoppingList.gradientForStore(store: store))
            .frame(height: rectangleHeight)
            .overlay {
                HStack(alignment: .center, content: {
                    Text(product)
                        .font(.system(size: 20))
                        .position(isHidden ? CGPoint(x: 140.0, y: Double(rectangleHeight/2) ) : CGPoint(x: 60.0, y: Double(rectangleHeight/2))).animation(.spring(.bouncy), value: isHidden)
                        .foregroundColor(textColorForStore(store: store))
                    Text(category)
                        .bold()
                        .foregroundColor(textColorForStore(store: store))
                        .position(CGPoint(x: 60.0, y: Double(rectangleHeight/2)))
                        .font(.system(size: 20))
                        .opacity(isHidden ? 0 : 1).animation(.easeInOut, value: isHidden)
                    Text(String(number))
                        .foregroundColor(textColorForStore(store: store))
                        .frame(alignment: .center)
                        .position(isHidden ? CGPoint(x: 50.0, y: Double(rectangleHeight/2)) : CGPoint(x: 60.0, y: Double(rectangleHeight/2))).animation(.spring(.bouncy), value: isHidden)
                        .font(.system(size: 30))
                })
                .onAppear(){
                    
                }
                
            }
    }
    private func textColorForStore(store: ShoppingList.StoreName) -> Color {
        switch store {
        case .Tesco:
            return Color.black
        case .none:
            return Color.white
        case .Billa:
            return Color.white
        case .Malina:
            return Color.black
        case .Lidl:
            return Color.white
        case .Coop:
            return Color.black
        case .Biedronka:
            return Color.white
        }
    }

}

#Preview {
    ShoppingProduct(isHidden: .constant(false), product: "Apple", category: "Fruits", number: 3, store: .Billa)
}
