//
//  SideMenu.swift
//  Incidencias
//
//  Created by Eine Dereh on 14/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SideMenu: View {
    @State private var userEmail: String = ""
    @State private var userName: String = "Loading..."
    @State private var role: String = ""
    @State private var isLoading = true
    @StateObject private var userDataFetcher = UserDataFetcher()
    
    @State var userIsLoggedIn:Bool = false
    @State var updater: Bool = false
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 14) {
                HStack{
                    Image("laptopbg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                    Spacer()
                }
                
                if userDataFetcher.isLoading {
                    Text("Loading...")
                        .font(.title2.bold())
                } else if let error = userDataFetcher.errorMessage {
                    Text("\(error)")
                        .font(.title2.bold())
                        .foregroundColor(.red)
                } else {
                    Text("\((userDataFetcher.profileData["name"] as? String)!)")
                        .font(.title2.bold())
                    
                    Text("\((userDataFetcher.profileData["role"] as? String)!)")
                        .font(.callout)
                }
                
                Button(action: {
                    path.append("Profile")
                }
                       , label: {
                    Image(systemName: "person")
                    Text("Perfil").font(.title3.bold())
                })
                .padding(.top)

                Button(action: {
                    path.append("ListIncidencias")
                }
                       , label: {
                    Image(systemName: "list.dash")
                    Text("Listar Incidencias").font(.title3.bold())
                })
                .padding(.top)
                
                Button(action: {
                    path.append("RegIncidencias")
                }
                       , label: {
                    Image(systemName: "arrow.up.doc")
                    Text("Registrar incidencias").font(.title3.bold())
                })
                .padding(.top)

                
                Spacer()
                
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        path = NavigationPath()
                    }
                    catch let error {
                        print("Error signing out: \(error)")
                    }
                }
                       , label: {
                    Text("Salir").font(.title2.bold())
                })
                .padding(.bottom)
            }
            .padding(.horizontal)
            .padding(.leading)
            
        }
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(
            Color("lightGray")
                .opacity(0.4)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/*
struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
*/
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
