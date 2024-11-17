//
//  ContentView.swift
//  regIncidencias
//
//  Created by Kevin Amaya on 12/10/24.
//



import SwiftUI

struct RegIncidencias: View {
    // @State private var selectedBranch = ""
    // @State private var selectedIncidentType = ""
    // @State private var selectedCategory = ""
    
    // @State private var showImagePicker = false
    // @State private var selectedImage: UIImage? = nil
    
    @Binding var path: NavigationPath
    
    @StateObject private var incidentTypeViewModel = IncidentsTypeViewModel()
    @StateObject private var branchesViewModel = BranchesViewModel()
    @StateObject private var incidentsViewModel = IncidentsViewModel()
    
    @State private var showAlert: Bool = false
    @State private var alertType: AlertType? = nil
    
    @State private var description = ""
    @State private var branches: String? = nil
    @State private var incidentTypes: String? = nil
    
    enum AlertType {
            case emptyTextField
            case confirmation
        }
    
    var body: some View {
        VStack{
            TopBarBasic().ignoresSafeArea()
            VStack {
                Text("Registrar incidencia")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                if incidentTypeViewModel.items.isEmpty {
                    Text("Loading items...")
                } else {
                    Picker("Tipo de incidencia", selection: $incidentTypes) {
                        Text("Selecciona un tipo de incidencia").foregroundColor(.gray).tag(nil as String?)
                        
                        ForEach(incidentTypeViewModel.items, id: \.self) { item in
                            Text(item).tag(item as String?)
                        }
                    }
                    .tint(.blue)
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                
                if branchesViewModel.items.isEmpty {
                    Text("Loading items...")
                } else {
                    Picker("Sucursal", selection: $branches) {
                        Text("Selecciona una sucursal").foregroundColor(.gray).tag(nil as String?)
                        
                        ForEach(branchesViewModel.items, id: \.self) { item in
                            Text(item).tag(item as String?)
                        }
                    }
                    .tint(.blue)
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                
                // Descripción
                TextField("Descripción", text: $description)
                    .tint(.black)
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
                        path.removeLast()
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
                        showAlert = true
                        if(incidentTypes == nil || branches == nil || description.isEmpty) {
                            alertType = .emptyTextField
                            print("error")
                        } else {
                            incidentsViewModel.addItem(type: incidentTypes!, branch: branches!, description: description)
                            alertType = .confirmation
                        }
                    }) {
                        Text("Registrar")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .alert(isPresented: $showAlert) {
                                switch alertType {
                                case .emptyTextField:
                                    return Alert(
                                        title: Text("Atencion").foregroundColor(.red),
                                        message: Text("Campos sin completar, porfavor intentelo de nuevo"),
                                        dismissButton: .default(Text("Aceptar"))
                                    )
                                case .confirmation:
                                    return Alert(
                                        title: Text("Datos añadidos exitosamente").foregroundColor(.blue),
                                        message: Text("Los datos han sido añadidos de forma exitosa."),
                                        dismissButton: .default(Text("Aceptar"))
                                    )
                                case .none:
                                    return Alert(title: Text("Error"))
                                }
                            }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            
            //NavigationView
            BottomBar()
        }.onAppear {
            incidentTypeViewModel.fetchTypes()
            branchesViewModel.fetchNames()
        }
    }
}

/*
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
*/
/*
struct regIncidenciasView_Previews: PreviewProvider {
    @State private var path = NavigationPath()
    
    static var previews: some View {
        RegIncidencias(path: $path)
    }
}
*/
