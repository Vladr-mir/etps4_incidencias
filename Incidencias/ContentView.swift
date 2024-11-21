//
//  ContentView.swift
//  Incidencias
//
//  Created by Eine Dereh on 10/10/24.
//

import SwiftUI
import Foundation
// import UIKit
import Firebase


struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showMenu = false
    @State var userIsLoggedIn = false
    @State private var path = NavigationPath()
    @State private var updater:Bool = false
    @EnvironmentObject var userData: UserDataFetcher
    //@StateObject private var userDataFetcher = UserDataFetcher()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                ZStack {
                    Image("laptopbg")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .scaledToFit()
                        .overlay(
                            Color.black.opacity(0.2)
                        )
                    //.offset(y: -50)
                        .clipped()
                    
                    Image("logo_incident_fixed")
                        .resizable()
                        .frame(width: 200, height: 190)
                        .scaledToFit()
                    //.offset(y: -50)
                        .clipped()
                }.ignoresSafeArea()
                
                Spacer()
                
                TextField("Email", text: $email)
                    .tint(.black)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                
                SecureField("Password", text: $password)
                    .tint(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    login(email: email, password: password)
                    if userIsLoggedIn {
                        userData.fetchUserData()
                        path.append("MainMenu")
                    }
                    
                    updater = true
                }, label: {
                    Text("Login")
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }).navigationDestination(for: String.self) { value in
                    if value == "MainMenu" {
                        MainMenu(path: $path)
                    }
                    
                    if value == "Profile" {
                        Profile(path: $path)
                    }
                    
                    if value == "ListIncidencias" {
                        ListIncidencias(path: $path)
                    }
                    
                    if value == "RegIncidencias" {
                        RegIncidencias(path: $path)
                    }
                    
                }
                // NavigationLink controlled by the state variable
                Spacer()
                
                BottomBar()
            }.onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn = true
                        userData.fetchUserData()
                        path.append("MainMenu")
                    } else {
                        userIsLoggedIn = false
                    }
                }
            }
        }.tint(Color.white)
    }
    
    private func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if error != nil {
                print("Error signing in: \(error!.localizedDescription)")
                // Display an error message to the user
            } else {
                // Sign-in successful
                print("User signed succesfully")
                // Navigate to the next screen (e.g., home screen)
                userIsLoggedIn = true
            }
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
