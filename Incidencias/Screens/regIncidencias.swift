//
//  ContentView.swift
//  regIncidencias
//
//  Created by Kevin Amaya on 12/10/24.
//



import SwiftUI

struct RegIncidencias: View {
    @State private var selectedBranch = ""
    @State private var selectedIncidentType = ""
    @State private var selectedCategory = ""
    @State private var description = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil

    let branches = ["            Sucursal El Salvador           ", "Sucursal 2", "Sucursal 3"]
    let incidentTypes = ["          Tipo de Incidencia              ", "Tipo 2", "Tipo 3"]
    let categories = ["                      Categoría                  ", "Categoría 2", "Categoría 3"]

    var body: some View {
        NavigationView {
            VStack {
                Text("Registrar incidencia")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // Sucursal
                Picker("Sucursal", selection: $selectedBranch) {
                    ForEach(branches, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .frame(maxWidth: .none)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
             

                // Tipo de incidencia
                Picker("Tipo de incidencia", selection: $selectedIncidentType) {
                    ForEach(incidentTypes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .frame(maxWidth: .none)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
               

                // Categorías
                /*
                Picker("Categoría", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .frame(maxWidth: .none)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
               */

                // Descripción
                TextField("Descripción", text: $description)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding()

                // Agregar Fotografía
                /*
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    HStack {
                        Text(selectedImage == nil ? "Agregar fotografía" : "Fotografía agregada")
                        Spacer()
                        Image(systemName: "paperclip")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding()
                 */

                HStack {
                    // Botón Cancelar
                    Button(action: {
                        // Acción de cancelar
                    }) {
                        Text("Cancelar")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }

                    // Botón Registrar
                    Button(action: {
                        // Acción de registrar
                    }) {
                        Text("Registrar")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding()

                Spacer()

                // Enlace de reporte técnico
                HStack {
                    Text("¿Tiene problemas técnicos?")
                    NavigationLink("Repórtelo.", destination: Text("Pantalla de reporte técnico"))
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 20)

            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            .navigationBarTitle("NombreUsuario", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // Acción del botón del menú
            }) {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.white)
            })
            .background(Color(UIColor.systemBackground))
        }
    }
}

// Implementación del ImagePicker (puedes utilizar tu propio código para manejar imágenes)
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}




struct regIncidenciasView_Previews: PreviewProvider {
    static var previews: some View {
        RegIncidencias()
    }
}
