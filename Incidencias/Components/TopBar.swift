//
//  TopBar.swift
//  Incidencias
//
//  Created by Eine Dereh on 10/10/24.
//

import SwiftUI

struct TopBar: View {
    @StateObject private var userDataFetcher = UserDataFetcher()
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color("mainColor"))
                .frame(width: .infinity, height: 80)
                .overlay(
                    HStack {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(Color.white)
                        Spacer()
                        if userDataFetcher.isLoading {
                            Text("Loading...")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        } else if let error = userDataFetcher.errorMessage {
                            Text("\(error)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        } else {
                            Text("\((userDataFetcher.profileData["username"] as? String)!)")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.trailing)
                        }
                    }.padding(.horizontal)
                )
        }
    }
}

struct TopBarBasic: View {
    @StateObject private var userDataFetcher = UserDataFetcher()
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color("mainColor"))
                .frame(width: .infinity, height: 80)
                .overlay(
                    HStack {
                        Spacer()
                        if userDataFetcher.isLoading {
                            Text("Loading...")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        } else if let error = userDataFetcher.errorMessage {
                            Text("\(error)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        } else {
                            Text("\((userDataFetcher.profileData["username"] as? String)!)")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.trailing)
                        }
                        
                    }.padding(.horizontal)
                )
        }
    }
}


struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
