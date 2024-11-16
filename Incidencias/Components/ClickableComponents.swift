//
//  ClickableComponents.swift
//  Incidencias
//
//  Created by Eine Dereh on 12/10/24.
//

import Foundation
import SwiftUI

struct btnBlue: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(Color("btnColor1"))
                    .frame(width: 350, height: 65)
                    .cornerRadius(30)
                )
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .frame(width: 350)
            //.clipShape(Rectangle())
    }
}

struct MenuBtnBlue: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: 150, height: 65)
                    .cornerRadius(30)
                )
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .frame(width: 150)
            //.clipShape(Rectangle())
    }
}

struct MenuBtnRed: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(Color("btnColor2"))
                    .frame(width: 150, height: 65)
                    .cornerRadius(30)
                )
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .frame(width: 150)
            //.clipShape(Rectangle())
    }
}
