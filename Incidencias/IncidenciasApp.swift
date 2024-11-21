//
//  IncidenciasApp.swift
//  Incidencias
//
//  Created by Eine Dereh on 10/10/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
    return true
  }
}

@main
struct IncidenciasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userData = UserDataFetcher()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userData)
        }
    }
}
