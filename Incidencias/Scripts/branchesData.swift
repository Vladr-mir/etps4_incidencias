//
//  branchesData.swift
//  Incidencias
//
//  Created by Eine Dereh on 16/11/24.
//

import Foundation
import SwiftUI
import Firebase

class BranchesViewModel: ObservableObject {
    @Published var items: [String] = []
    
    // Fetch items from Firestore
    func fetchNames() {
        let db = Firestore.firestore()
        db.collection("branches").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching items: \(error)")
                return
            }
            
            // Extract item names from Firestore documents
            if let documents = snapshot?.documents {
                DispatchQueue.main.async {
                    self.items = documents.compactMap { document in
                        document.get("name") as? String
                    }
                }
            }
        }
    }
}
