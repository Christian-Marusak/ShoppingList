//
//  AuthManager.swift
//  ShoppingList
//
//  Created by Christián on 05/04/2024.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class AuthManager {

    func createUser(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
}
