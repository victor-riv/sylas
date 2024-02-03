//
//  sylas_swiftuiApp.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 1/29/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FacebookCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        // Initiate Facebook SDK
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        let handledByFacebook = ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        let handledByGoogle = GIDSignIn.sharedInstance.handle(url)
        
        return handledByFacebook || handledByGoogle
    }
}

@main
struct sylas_swiftuiApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticator = Authenticator.shared
    
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authenticator.isAuthenticated {
                    ItineraryView()
                } else {
                    UnauthenticatedHomeView()
                }
            }
            .environmentObject(authenticator)
            .preferredColorScheme(.dark)
        }
    }
}

