//
//  ShowIncidencia.swift
//  Incidencias
//
//  Created by Eine Dereh on 16/11/24.
//

import SwiftUI

struct ShowIncidencia: View {
    let type: String
    let branch: String
    let description: String
    @Binding var path: NavigationPath
    
    var body: some View {
        TopBarBasic().ignoresSafeArea()
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Tipo")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    Text("\(type)")
                }
                VStack(alignment: .leading) {
                    Text("Sucursal")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    Text("\(branch)")
                }
                VStack(alignment: .leading) {
                    Text("Descripcion")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    Text("\(description)")
                }
            }
            Spacer()
        }.padding(50)
        
        Spacer()
        BottomBar()
    }
}

/*
 struct ShowIncidencia_Previews: PreviewProvider {
    static var previews: some View {
        ShowIncidencia(type: "AHh", branch: "String", description: "ajkljl")
    }
}
*/

