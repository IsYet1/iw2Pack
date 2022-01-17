//
//  FungiListViewModel.swift
//  U_FungiFinder
//
//  Created by Don McKenzie on 11/29/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum LoadingState {
    case idle
    case loading
    case success
    case failure
}

class FungiListViewModel: ObservableObject {
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    @Published var fungi: [FungiViewModel] = []
    @Published var loadingState: LoadingState = .idle
    
    func getAllFungiForUser() {
        DispatchQueue.main.async {
            self.loadingState = .loading
        }
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        db.collection("fungi")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.loadingState = .failure
                    }
                } else {
                    if let snapshot = snapshot {
                        let fungi: [FungiViewModel] = snapshot.documents.compactMap {doc in
                            var fungi = try? doc.data(as: Fungi.self)
                            fungi?.id = doc.documentID
                            if let fungi = fungi {
                                return FungiViewModel(fungi: fungi)
                            }
                            return nil
                        }
                        // self must be ? here because it might be nil
                        DispatchQueue.main.async {
                            print("Pictures loaded. Starting the list.")
                            self?.fungi = fungi
                            self?.loadingState = .success
                        }
                    }
                }
            }
    }
    
    func save(name: String, url: URL, completion: (Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        do {
            let _ = try db.collection("fungi").addDocument(from: Fungi(
                name: name, photoUrl: url.absoluteString, userId: currentUser.uid
            ))
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func uploadPhoto(data: Data, completion: @escaping (URL?) -> Void) {
        let imageName = UUID().uuidString
        
        let storageRef = storage.reference()
        let photoRef = storageRef.child("images/\(imageName).png")
        
        photoRef.putData(data, metadata: nil) {metadata, error in
            photoRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    completion(url)
                }
            }
        }
    }
    
}
