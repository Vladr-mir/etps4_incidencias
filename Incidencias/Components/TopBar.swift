//
//  TopBar.swift
//  Incidencias
//
//  Created by Eine Dereh on 10/10/24.
//

import SwiftUI

struct TopBar: View {
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
                        Text("Nombre de usuario")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.trailing)
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
