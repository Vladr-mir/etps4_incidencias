//
//  Profile.swift
//  Incidencias
//
//  Created by Eine Dereh on 12/10/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Profile: View {
    @State private var userEmail: String = ""
    @State private var userName: String = "Loading..."
    @State private var role: String = ""
    @State private var isLoading = true
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarGrey().ignoresSafeArea()
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.horizontal, 50)
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Nombre")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                        Text("\(userName)")
                    }
                    VStack(alignment: .leading) {
                        Text("Rol")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                        Text("\(role)")
                    }                }
                Spacer()
            }.padding(50)
            
            Spacer()
            BottomBar()
        }
        .tint(.black)
        .onAppear {
            fetchUserData()
        }
    }
    
    private func fetchUserData() {
        // Ensure the user is logged in
        if let currentUser = Auth.auth().currentUser {
            // Fetch user email from Firebase Authentication
            self.userEmail = currentUser.email ?? "No email available"
            
            // Optionally, fetch additional data (e.g., name) from Firestore
            fetchUserProfile(userId: currentUser.uid)
        } else {
            self.isLoading = false
            self.userEmail = "No user logged in"
        }
    }
    
    private func fetchUserProfile(userId: String) {
        let db = Firestore.firestore()
        
        // Fetch additional user data from Firestore (if available)
        db.collection("users").document(userId).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.userName = data?["name"] as? String ?? "No name available"
                self.role = data?["role"] as? String ?? "No role available"
            } else {
                self.userName = "No profile found"
                self.role = "No role found"
            }
            self.isLoading = false
        }
    }
}

