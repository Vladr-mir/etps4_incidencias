//
//  ShowIncidencia.swift
//  Incidencias
//
//  Created by Eine Dereh on 16/11/24.
//

import SwiftUI

struct ShowIncidencia: View {
    /*let uid: String
     let type: String
     let branch: String
     let description: String*/
    let incident: Item
    let viewModel: IncidentsViewModel
    @Binding var path: NavigationPath
    
    var body: some View {
        TopBarBasic().ignoresSafeArea()
        VStack(alignment: .leading, spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: (UIScreen.main.bounds.width - 30), height: 400)
                    .padding()
                VStack(alignment: .leading) {
                    Text("\(incident.type)").font(.title.bold()).foregroundColor(.blue)
                    Text("Sucursal")
                        .font(.title2.bold())
                    Text("\(incident.branch)")
                    Text("Descripcion").font(.title2.bold())
                    ScrollView {
                        HStack {
                            Text("\(incident.description)")
                            Spacer()
                        }
                    }.frame(maxWidth: (UIScreen.main.bounds.width - 60), maxHeight: 100, alignment: .center)
                    
                    Text("\(incident.time.formatted())").foregroundColor(.gray)
                    Button(action: {
                        viewModel.markAsSolved(documentID: incident.id)
                        path.removeLast()
                    }, label: {
                        Text("Marcar como resuelta")
                            .padding()
                            .buttonStyle(.borderedProminent)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                }
            }
            
        }
        
        Spacer()
        BottomBar()
    }
}

/*
 struct ShowIncidencia_Previews: PreviewProvider {
 static var previews: some View {
 ShowIncidencia()
 }
 }
 */

