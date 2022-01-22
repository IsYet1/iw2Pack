//
//  ItemListViewModel.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class PackListViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var items: [ItemViewModel] = []
    @Published var loadingState: LoadingState = .idle
    
    func getAllItems() {
        DispatchQueue.main.async {
            self.loadingState = .loading
        }
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        db.collection("pack").document("data").collection("items")
        db.collection("pack").document("data").collection("lists")
//        db.collection("pack").document("data").collection("lists").document("ohio").collection("items")
        
        //            .whereField("userId", isEqualTo: currentUser.uid)
        
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.loadingState = .failure
                    }
                } else {
                    if let snapshot = snapshot {
                        let items: [ItemViewModel] = snapshot.documents.compactMap {doc in
                            var item = try? doc.data(as: Item.self)
                            item?.id = doc.documentID
                            print("Line 41 \(doc.documentID) \(doc.data())")
                            if let item = item {
                                print("Item found in the loop: \(item)")
                                return ItemViewModel(item: item)
                            }
                            return nil
                        }
                        // self must be ? here because it might be nil
                        DispatchQueue.main.async {
                            print("Items loaded. Starting the list.")
                            self?.items = items
                            self?.loadingState = .success
                        }
                    }
                }
            }
    }
 
}

