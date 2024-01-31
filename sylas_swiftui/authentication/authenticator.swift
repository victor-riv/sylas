//
//  authenticator.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin


class Authenticator: ObservableObject {
    static let shared = Authenticator()
    
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    
    private init(){
        currentUser = Auth.auth().currentUser
        isAuthenticated = currentUser != nil
    }
    
    func signUpWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("FML")
                completion(.failure(error))
            }
            if let user = authResult?.user {
                print("Success babyyyyy")
                self?.currentUser = user
                self?.isAuthenticated = true
                completion(.success(user))
            }
        }
    }
    
    func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let presentingViewController = getTopViewController() else {return}
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] result, error in
            guard error == nil else {
                // ...
                print("error here")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("something else happened")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            print("onto something")
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Google Sign In Error")
                    completion(.failure(error))
                }
                
                if let user = result?.user {
                    self?.currentUser = user
                    self?.isAuthenticated = true
                    print("Authenticated in Firebase")
                    completion(.success(user))
                }
            }
        }
    }
    
    func signInWithFacebook(completion: @escaping (Result<User, Error>) -> Void) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: nil) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let accessToken = AccessToken.current else {
                completion(.failure(NSError(domain: "FacebookLoginError", code: 0, userInfo: nil)))
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let user = authResult?.user {
                    self.currentUser = user
                    self.isAuthenticated = true
                    completion(.success((user)))
                }
                
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
            completion(.failure(signOutError))
        }
    }
}

func getTopViewController() -> UIViewController? {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
    guard let rootViewController = windowScene.windows.first?.rootViewController else { return nil }
    
    var topViewController = rootViewController
    while let presentedViewController = topViewController.presentedViewController {
        topViewController = presentedViewController
    }
    
    return topViewController
}


