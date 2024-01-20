//
//  HoldForMoreView.swift
//  ShoppingList
//
//  Created by Christian Marušák on 10/01/2024.
//

import SwiftUI

struct HoldForMoreView: View {
    
    @State private var isTouching = false
    @State private var secondTouch = false
    @State private var selectedOption: String?
    @State private var options : [String] = ["rozok","maslo","vodka"]
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: secondTouch ? 120 : 100).animation(.bouncy, value: secondTouch)
                    .frame(width: isTouching ? 100 : 50)
                    .offset(x: isTouching ? -130 : 0, y: isTouching ? -120 : 0).animation(.bouncy, value: isTouching)
                    
                Circle()
                    .fill(Color.red)
                    .frame(width: isTouching ? 100 : 50)
                    .offset(x: isTouching ? 0 : 0, y: isTouching ? -120 : 0).animation(.bouncy, value: isTouching)
                Circle()
                    .fill(Color.green)
                    .frame(width: isTouching ? 100 : 50)
                    .offset(x: isTouching ? 130 : 0, y: isTouching ? -120 : 0).animation(.bouncy, value: isTouching)
                Circle()
                    .fill(isTouching ? Color.red : Color.gray)
                    .frame(width: 100, height: 100)
                    .gesture(
                        DragGesture(minimumDistance: 100)
                            .onChanged { value in
                                isTouching = true
                                if value.location.y >= -180  && value.location.y <= -120 /*&& value.location.x >= -109 && value.location.x <= -39*/ {
                                    print("Prva polozka")
                                    secondTouch = true
                                } else {
                                    secondTouch = false
                                }
                            }
                            .onEnded { _ in
                                isTouching = false
                                selectedOption = nil
                                // Tu môžete implementovať ďalšie akcie pri ukončení dotyku
                            }
                    )
            }
            
            
        }
    }
}


#Preview {
    HoldForMoreView()
}
