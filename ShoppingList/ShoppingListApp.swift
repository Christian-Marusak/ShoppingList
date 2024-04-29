//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Christian Marušák on 16/11/2023.
//

import SwiftUI
import FirebaseCore


@main
struct ShoppingListApp: App {
    
    let authManager = AuthManager()
    
    @StateObject var shoppingViewModel = ShoppingViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(selectedCategory: Categories(rawValue: "") ?? .bakery)
//            LoginView()
        }
        .environmentObject(shoppingViewModel)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
