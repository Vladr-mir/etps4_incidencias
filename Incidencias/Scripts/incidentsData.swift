//
//  incidentsData.swift
//  Incidencias
//
//  Created by Eine Dereh on 16/11/24.
//

import Foundation
import SwiftUI
import Firebase

class IncidentsViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private var db = Firestore.firestore()
    
    init() {
        fetchItems()
    }
    
    func addItem(type: String, branch: String, description: String) {
        let id = UUID().uuidString
        let newItem = Item(id: id, type: type, branch: branch, description: description)
        let itemData = newItem.toDictionary()
        
        db.collection("incidents").document(newItem.id).setData(itemData) { error in
            if let error = error {
                self.errorMessage = "Error adding item: \(error.localizedDescription)"
                print(self.errorMessage ?? "")
            } else {
                print("Item successfully added!")
                // Optionally fetch updated items list after adding a new item
                self.fetchItems()
            }
        }
    }
    
    // Fetch all documents from Firestore collection "items"
    func fetchItems() {
        db.collection("incidents").getDocuments { (snapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error fetching items: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.errorMessage = "No documents found."
                    self.isLoading = false
                    return
                }
                
                // Map Firestore documents to Item model
                self.items = documents.compactMap { document in
                    let data = document.data()
                    let id = document.documentID
                    // let title = data["title"] as? String ?? "Untitled"
                    let description = data["description"] as? String ?? "No description"
                    let branch = data["branch"] as? String ?? "No branch"
                    let type = data["type"] as? String ?? "No type"
                    return Item(id: id, type: type, branch: branch, description: description)
                }
                
                self.isLoading = false
            }
        }
    }
}

struct Item: Identifiable {
    var id: String
    var type: String
    var branch: String
    var description: String
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "type": type,
            "branch": branch,
            "description": description
        ]
    }
}

