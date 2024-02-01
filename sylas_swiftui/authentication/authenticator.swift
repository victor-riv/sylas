//
//  authenticator.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/30/24.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin


class Authenticator: ObservableObject {
    static let shared = Authenticator()
    
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    private init(){
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isAuthenticated = user != nil
            self?.currentUser = user
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        createUser(email: email, password: password)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    completion(.failure(error))
                }
            }, receiveValue: { user in
                completion(.success(user))
            })
            .store(in: &cancellables)
    }
    
    private func createUser(email: String, password: String) -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = authResult?.user {
                    promise(.success(user))
                } else {
                    let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
            self.currentUser = nil
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
            
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


