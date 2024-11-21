//
//  usersData.swift
//  Incidencias
//
//  Created by Eine Dereh on 15/11/24.
//

import Foundation

import Firebase

class UserDataFetcher: ObservableObject {
    @Published var email: String = ""
    @Published var displayName: String = ""
    @Published var profileData: [String: Any] = [:]
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?

    //init() {
      //  fetchUserData()
    //}

    // Function to fetch user data
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else {
            self.errorMessage = "No user is currently logged in."
            self.isLoading = false
            return
        }

        // Fetch user data from Firebase Authentication
        self.email = user.email ?? "No email available"
        self.displayName = user.displayName ?? "No display name available"

        // Fetch additional user profile data from Firestore
        fetchUserProfileData(uid: user.uid)
    }

    // Function to fetch additional user data from Firestore
    private func fetchUserProfileData(uid: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)

        docRef.getDocument { (document, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error fetching user profile: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }

                if let document = document, document.exists {
                    self.profileData = document.data() ?? [:]
                } else {
                    self.errorMessage = "No profile data found."
                }
                self.isLoading = false
            }
        }
    }
}

