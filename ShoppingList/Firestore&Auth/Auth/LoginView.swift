//
//  LoginView.swift
//  ShoppingList
//
//  Created by Christián on 05/04/2024.
//

// MARK: - Logic behing Login View

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    let authManager = AuthManager()
//    let userManager = UserManager()
    @Published var loginMail: String = ""
    @Published var loginPassword = ""
    @Published var name = ""
    @State var showAlert: Bool = false
    
    
    
    func callCreateUser() async {
        if loginMail.contains("@") && loginPassword.count >= 8 {
            do {
                try await authManager.createUser(email: loginMail, password: loginPassword)
                await MainActor.run {
                    loginMail = ""
                    loginPassword = ""
                    name = ""
                }
//                try await userManager.saveToDatabase(user: DatabaseUser(id: "Test User", email: "Test@mail.com", isPremium: false, name: "Test", dateCreated: Date(timeIntervalSinceReferenceDate: .pi)))
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Password is bad or mail is bad")
            showAlert = true
        }
        
    }
    func callLoginUser() async {
        do {
            try await authManager.loginUser(email: loginMail, password: loginPassword)
            await MainActor.run {
                loginMail = ""
                loginPassword = ""
                name = ""
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

// MARK: - User Interface of LoginView

struct LoginView: View {
    @State var register: Bool = true
    @StateObject var viewModel = LoginViewModel()
    
    
    var body: some View {
        Spacer()
        VStack {
            InputView(
                text: $viewModel.name,
                title: "Name",
                placeholder: "Enter you name"
            )
            .opacity(register ? 1 : 0)
            .animation(.easeIn, value: register)
            
            InputView(
                text: $viewModel.loginMail,
                title: "Email",
                placeholder: "Enter email"
            )
            InputView(
                text: $viewModel.loginPassword,
                title: "Password",
                placeholder: "Enter password",
                isSecureField: true
            )
            
            VStack {
                Button {
                    if register {
                        Task {
                            await viewModel.callCreateUser()
                        }
                    } else {
                        Task {
                            await viewModel.callLoginUser()
                        }
                        print("Login")
                    }
                } label: {
                    Text(register ? "register" : "login")
                        .animation(.easeIn, value: register)
                        .foregroundStyle(.shoppieSecondary)
                        .frame(width: 100, height: 40)
                        .background(.shoppiePrimary)
                        .cornerRadius(15)
                    
                }
                Button {
                    register.toggle()
                }label: {
                    HStack {
                        Text(register ? "i have account i want to" : "I dont have account i want to")
                            .font(.footnote)
                        Text(register ? "login" : "register")
                            .font(.footnote)
                            .bold()
                    }
                }
            }
            .padding(50)
        }
        .padding()
        
    }
}



#Preview {
    LoginView()
}
