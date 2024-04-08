////
////  SettingsView.swift
////  ShoppingList
////
////  Created by Christian Marušák on 13/12/2023.
////
//
//import SwiftUI
//
//struct SettingsView: View {
//    var body: some View {
//                List{
//                    Section{
//                        HStack{
//                            Text(user.initials)
//                                .fontWeight(.semibold)
//                                .font(.title)
//                                .foregroundStyle(Color.white)
//                                .frame(width: 72, height: 72)
//                                .background(Color.gray)
//                                .clipShape(.circle)
//                            VStack(alignment: .leading, spacing: 4){
//                                Text(user.fullName)
//                                    .font(.subheadline)
//                                    .fontWeight(.semibold)
//                                    .padding(.top, 4)
//                                Text(user.email)
//                                    .font(.footnote)
//                                    .foregroundStyle(Color(.systemGray))
//                            }
//                        }
//                    }
//                    Section("General"){
//                        HStack {
//                            SettingsRowView(image: "gear", title: "Version", tintColor: Color(.systemGray))
//                            Spacer()
//                            Text("1.0.0")
//                                .font(.subheadline)
//                                .foregroundStyle(Color(.systemGray))
//                        }
//                    }
//                    Section("Account"){
//                        Button(action: {
//                            print("Sign out")
//                            viewModel.signOut()
//                        }, label: {
//                            SettingsRowView(image: "arrow.left.circle.fill", title: "Sign out", tintColor: .red)
//                        })
//                        Button(action: {
//                            print("Account deleted")
//                        }, label: {
//                            SettingsRowView(image: "xmark.circle.fill", title: "Delete account", tintColor: .red)
//                        })
//                    }
//                }
//
//    }
//}
//
//#Preview {
//    SettingsView()
//}
