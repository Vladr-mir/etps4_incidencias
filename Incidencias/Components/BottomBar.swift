//
//  BottomBar.swift
//  Incidencias
//
//  Created by Eine Dereh on 11/10/24.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color("lightGray"))
                .frame(width: .infinity, height: 60)
                .overlay(
                    HStack {
                        Text("¿Algún problema?")
                            .fontWeight(.light)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.trailing)
                        Text("Contactanos")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                            .multilineTextAlignment(.trailing)
                    }.padding(.horizontal)
                )
        }
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar()
    }
}
