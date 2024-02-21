import UIKit
import SwiftUI
var greeting = "Hello, playground"
let units = [["orange", "watermelon", "apple", "banana"],["orange", "watermelon", "apple", "banana"],["orange", "watermelon", "apple", "banana"]]
let filterWord = "orange"
let filterData = units.map {$0.filter{ $0 == filterWord} }

print(filterData)
