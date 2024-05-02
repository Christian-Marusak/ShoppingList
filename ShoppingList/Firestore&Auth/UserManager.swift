//
//  DBManager.swift
//  ShoppingList
//
//  Created by Christián on 10/04/2024.
//

import Foundation
import FirebaseFirestore

class UserManager {
    let db = Firestore.firestore()
    func saveToDatabase (user: DatabaseUser) async throws {
        do {
            let ref = try await db.collection("users").addDocument(data: [
                "first": "Ada",
                "last": "Lovelace",
                "born": 1815
              ])
          print("Document added with ID: \(ref.documentID)")
        } catch {
          print("Error adding document: \(error)")
        }
    }
}
