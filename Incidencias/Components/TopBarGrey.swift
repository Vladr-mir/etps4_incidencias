//
//  TopBarGrey.swift
//  Incidencias
//
//  Created by Eine Dereh on 15/11/24.
//

import SwiftUI

struct TopBarGrey: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color("lightGray"))
                .frame(width: .infinity, height: 80)
                .overlay(
                    HStack {
                        Spacer()
                        Text("Nombre de usuario")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.trailing)
                    }.padding(.horizontal)
                )
        }
    }
}

struct TopBarGrey_Previews: PreviewProvider {
    static var previews: some View {
        TopBarGrey()
    }
}
