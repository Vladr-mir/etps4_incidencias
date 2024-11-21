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
    @Binding var path: NavigationPath
    
    //@StateObject private var userDataFetcher = UserDataFetcher()
    @EnvironmentObject var userDataFetcher: UserDataFetcher
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopBarBasic().ignoresSafeArea()
            HStack {
                Image("defaultProfile")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 20) {
                if userDataFetcher.isLoading {
                    ProgressView("Loading user data...")
                } else if let error = userDataFetcher.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: (UIScreen.main.bounds.width - 30), height:250)
                            .padding()
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Usuario").font(.title.bold()).foregroundColor(.blue)
                                Text("\((userDataFetcher.profileData["username"] as? String)!)")
                                
                                Text("Nombre").font(.title.bold()).foregroundColor(.blue)
                                Text("\((userDataFetcher.profileData["name"] as? String)!)")
                                
                                Text("Rol").font(.title.bold()).foregroundColor(.blue)
                                Text("\((userDataFetcher.profileData["role"] as? String)!)")
                            }.padding(50)
                            Spacer()
                        }
                    }
                }
                
                Button(action: {
                    path.removeLast()
                }, label: {
                    Text("Volver")
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                })
            }
            Spacer()

            BottomBar()
        }
        .tint(.black)
    }
}

