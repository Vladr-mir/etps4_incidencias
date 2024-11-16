//
//  ListIncidencias.swift
//  Incidencias
//
//  Created by Eine Dereh on 12/10/24.
//

import SwiftUI

struct ListIncidencias: View {
    var body: some View {
        VStack(spacing: 0) {
            TopBarGrey().ignoresSafeArea()
            
            NavigationView {
                List {
                    VStack(alignment: .leading){
                        Text("Incidencia 1")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                        Text("Detalles")
                    }
                    
                    VStack(alignment: .leading){
                        Text("Incidencia 1")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                        Text("Detalles")
                    }
                    
                    VStack(alignment: .leading){
                        Text("Incidencia 1")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                        Text("Detalles")
                    }
                    
                    VStack(alignment: .leading){
                        Text("Incidencia 1")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                        Text("Detalles")
                    }
                }
                .navigationTitle("Incidencias")
            }.background(Color.white)
            
            Spacer()
            BottomBar()
        }

    }
}

struct ListIncidencias_Previews: PreviewProvider {
    static var previews: some View {
        ListIncidencias()
    }
}
