//
//  SignUpView.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authenticator: Authenticator
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack (spacing: 50) {
                        IconButton(iconName: "apple.logo",
                                   fromAsset: false, action: {})
                        IconButton(iconName: "google", fromAsset: true, action: {
                            authenticator.signInWithGoogle { result in
                                switch result {
                                case .success(let user):
                                    print("Signed in successfully with user: \(user.uid)")
                                    showAlert = true
                                    alertMessage = "You have successfully signed in with Google"
                                    
                                case .failure(let error):
                                    print("Error signing in: \(error.localizedDescription)")
                                }
                            }
                        })
                        
                        IconButton(iconName: "facebook", fromAsset: true, action: {
                            authenticator.signInWithFacebook{ result in
                                switch result {
                                case .success(let user):
                                    print("Signed in successfully with user: \(user.uid)")
                                    showAlert = true
                                    alertMessage = "You have successfully signed in with Facebook"
                                    
                                case .failure(let error):
                                    print("Error signing in: \(error.localizedDescription)")
                                }
                            }
                        })
                        
                    }
                    .padding(.vertical, 20)
                    
                    DividerWithText(text: "Or create your account with email", fontSize: 14)
                    
                    LoginFormView()
                        .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .contentShape(Rectangle())
    }
    
}


struct LoginFormView: View {
    private enum Field: Int, CaseIterable {
        case email, password
    }
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Field?
    @EnvironmentObject var authenticator: Authenticator
    
    
    var body: some View {
        VStack (spacing: 20 ){
            TextField("Email", text: $email)
                .focused($focusedField, equals: .email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .focused($focusedField, equals: .password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding([.horizontal, .bottom])
            
            Button(action: submitLogin) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 224 / 255, green: 227 / 255, blue: 72 / 255))
                        .frame(height: 50)
                    
                    Text("Create Account")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
        }
    }
    
    func submitLogin() {
        focusedField = nil
        
        authenticator.signUp(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print("Signed up user: \(user.uid)")
                
                
            case .failure(let error):
                print("Error signing up: \(error)")
            }
        }
    }
}

struct IconButton: View {
    let iconName: String
    let fromAsset: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Group {
                if fromAsset {
                    // For images from the asset catalog
                    Image(iconName)
                        .resizable()
                    
                } else {
                    // For system images (SF Symbols)
                    Image(systemName: iconName)
                        .font(.system(size: 30))
                }
            }
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.black)
            .padding(10)
            .background(Color(red: 153 / 255, green: 153 / 255, blue: 153 / 255))
            .cornerRadius(5)
        }
    }
}



#Preview {
    NavigationView {
        SignUpView()
            .preferredColorScheme(.dark)
    }
}
