//
//  AuthUser.swift
//  ShoppingList
//
//  Created by Christián on 10/04/2024.
//

import Foundation
import FirebaseAuth

struct AuthUser {
    let userMail: String?
    let uid: String
    
    init(user: User) {
        self.userMail = user.email
        self.uid = user.uid
    }
}
