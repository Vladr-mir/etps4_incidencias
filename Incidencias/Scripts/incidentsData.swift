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
    @Published var retrievedDate: Date? = nil
    
    private var db = Firestore.firestore()
    
    init() {
        fetchItems()
    }
    
    func addItem(type: String, branch: String, description: String) {
        let id = UUID().uuidString
        let newItem = Item(id: id, type: type, branch: branch, description: description, isSolved: false, time: Date.now)
        let itemData = newItem.toDictionary()
        
        db.collection("incidents").document(newItem.id).setData(itemData) { error in
            if let error = error {
                self.errorMessage = "Error adding item: \(error.localizedDescription)"
                print(self.errorMessage ?? "")
            } else {
                print("Item successfully added!")
                self.fetchItems()
            }
        }
    }
    
    // Fetch all documents
    func fetchItems() {
        db.collection("incidents").whereField("isSolved", isEqualTo: false).limit(to: 200).getDocuments { (snapshot, error) in
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
                
                self.items = documents.compactMap { document in
                    let data = document.data()
                    let id = document.documentID
                    let description = data["description"] as? String ?? "No description"
                    let branch = data["branch"] as? String ?? "No branch"
                    let type = data["type"] as? String ?? "No type"
                    let isSolved = data["isSolved"] as? Bool ?? false

                    // Debugging log: Check the value of `time`
                    /*
                     if let timestamp = data["time"] as? Timestamp {
                        print("Document ID: \(id), Time: \(timestamp.dateValue())")
                    } else {
                        print("Document ID: \(id), Time field is missing or not a Timestamp.")
                    }
                    */
                    // Extract timestamp and convert to Date
                    let time: Date = (data["time"] as? Timestamp)?.dateValue() ?? Date.now
                    
                    return Item(id: id, type: type, branch: branch, description: description, isSolved: isSolved, time: time)
                }
                
                self.isLoading = false
            }
        }
    }

    
    func markAsSolved(documentID: String) {
        // Get a reference to the Firestore database
        let isSolved: Bool = true
        let db = Firestore.firestore()
        
        // Reference the document
        let documentRef = db.collection("incidents").document(documentID)
        
        // Update the field
        documentRef.updateData(["isSolved": isSolved]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated!")
            }
        }
    }
}

struct Item: Identifiable {
    var id: String
    var type: String
    var branch: String
    var description: String
    var isSolved: Bool
    var time: Date
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "type": type,
            "branch": branch,
            "description": description,
            "isSolved": isSolved,
            "time": FieldValue.serverTimestamp()
        ]
    }
}

