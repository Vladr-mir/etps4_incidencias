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
    
    @StateObject private var userDataFetcher = UserDataFetcher()
    
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
                    
                    if userDataFetcher.isLoading {
                        ProgressView("Loading user data...")
                    } else if let error = userDataFetcher.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                    } else {
                        VStack(alignment: .leading) {
                            Text("Nombre")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                            Text("\((userDataFetcher.profileData["name"] as? String)!)")
                        }
                        VStack(alignment: .leading) {
                            Text("Rol")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                            Text("\((userDataFetcher.profileData["role"] as? String)!)")
                        }
                    }
                }
                Spacer()
            }.padding(50)
            
            Spacer()
            BottomBar()
        }
        .tint(.black)
    }
}

