//
//  ShoppingProduct.swift
//  ShoppingList
//
//  Created by Christian Marušák on 22/11/2023.
//

import SwiftUI

struct ShoppingProduct: View {
    @State var isBought : Bool
    var unit : String
    var product : String
    var number: Double
    var rectangleHeight: CGFloat = 60
    var formattedNumber: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    
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
            Text(String(formattedNumber))
                .frame(alignment: .center)
                .font(.system(size: 15))
            Text(String(unit))
                .frame(alignment: .center)
                .font(.system(size: 15))
            //                            .padding(.trailing, 30)
        })
    }
}

#Preview {
    ShoppingProduct(isBought: true, unit: "mg", product: "Plnotučný jogurt ", number: 3.0).previewLayout(.sizeThatFits)
}
