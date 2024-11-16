//
//  ListIncidencias.swift
//  Incidencias
//
//  Created by Eine Dereh on 12/10/24.
//

import SwiftUI

struct ListIncidencias: View {
    @StateObject private var viewModel = IncidentsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarGrey().ignoresSafeArea()
            
            Text("Incidencias")
                .font(.title.bold())
            
            if viewModel.isLoading {
                ProgressView("Loading items...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                List(viewModel.items) { item in
                    VStack(alignment: .leading){
                        Text(item.type)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                        Text(item.description)
                    }
                }
            }
            
            /*
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
             */
            
            //NavigationView {
                
                
            //}.background(Color.white)
            
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
