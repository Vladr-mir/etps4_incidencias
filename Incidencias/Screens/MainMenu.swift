//
//  MainMenu.swift
//  Incidencias
//
//  Created by Eine Dereh on 12/10/24.
//

import SwiftUI
import Firebase

struct MainMenu: View {
    @State var offset: Float = 0
    @State var lastStoredOffset: Float = 0
    @State var showSideMenu: Bool = false
    
    @Binding var path: NavigationPath
    @EnvironmentObject var userData: UserDataFetcher

    
    var body: some View {
        VStack {
            HStack(spacing:0) {
                SideMenu(path: $path)
                
                VStack(spacing: 0) {
                    TopBar()
                        .ignoresSafeArea()
                        .overlay {
                            HStack {
                                Button(action: {
                                    showSideMenu.toggle()
                                }, label: {
                                    Rectangle()
                                        .frame(width:80, height: 80)
                                        .opacity(0)
                                })
                                Spacer()
                            }
                        }
                    Image("laptopbg")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -20)
                    Spacer()
                    
                    if(userData.profileData["role"] as? String == "operador") {
                        Button(action: {
                            path.append("RegIncidencias")
                        }, label: {
                            Text("Registrar incidencia")
                                .padding()
                                .buttonStyle(.borderedProminent)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        })
                    } else {
                        Button(action: {
                            path.append("ListIncidencias")
                        }, label: {
                            Text("Reporte")
                                .padding()
                                .buttonStyle(.borderedProminent)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        })
                    }
                    
                    Spacer()
                    BottomBar()
                }.frame(width: getRect().width)
            }
            .frame(width: getRect().width + getRect().width - 90)
            .offset(x: -(getRect().width - 90) / 2)
            .offset(x: CGFloat(offset))
            
            
        }
        .animation(.easeOut, value: offset == 0)
        .onChange(of: showSideMenu) { newValue in
            if showSideMenu && offset == 0 {
                offset = Float(getRect().width - 90)
                lastStoredOffset = offset
            }
            
            if !showSideMenu && offset == Float(getRect().width - 90) {
                offset = 0
                lastStoredOffset = 0
            }
        }.toolbar(.hidden, for: .navigationBar)
    }
}

//struct MainMenu_Previews: PreviewProvider {
//  static var previews: some View {
//MainMenu(path: )
// }
//}
