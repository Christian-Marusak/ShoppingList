//
//  LoginView.swift
//  ShoppingList
//
//  Created by Christián on 05/04/2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    let authManager = AuthManager()
    @Published var loginMail: String = ""
    @Published var loginPassword = ""
    
    
    func callCreateUser() async {
        do {
            try await authManager.createUser(email: loginMail, password: loginPassword)
            loginMail = ""
            loginPassword = ""
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    
    var body: some View {
        VStack {
            InputView(
                text: $viewModel.loginMail,
                title: "Email",
                placeholder: "Enter email"
            )
            InputView(
                text: $viewModel.loginPassword,
                title: "Heslo",
                placeholder: "Enter password",
                isSecureField: true
            )
            HStack {
                Button("Login") {
                    print("Login")
                }
                Button("Register") {
                    Task {
                        await viewModel.callCreateUser()
                    }
                    print("Register")
                }
            }
        }
        .padding()
        
    }
}



#Preview {
    LoginView()
}
