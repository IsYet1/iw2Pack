//
//  AllItemsListViewModel.swift
//  iw2Pack
//
//  Created by Don McKenzie on 25-Jan-22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AllItemsListViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var allItemsDict: [String: Item] = [:]
    @Published var allItems: [ItemViewModel] = []
    @Published var loadingState: LoadingState = .idle
    
    func getAllItems() {
        DispatchQueue.main.async {
            self.loadingState = .loading
        }
        db.collection("pack").document("data").collection("items")
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
                                print("Item found in the All Items loop: \(item)")
                                self?.allItemsDict[doc.documentID] = try? doc.data(as: Item.self)
                                return ItemViewModel(item: item)
                            }
                            return nil
                        }
                        // self must be ? here because it might be nil
                        DispatchQueue.main.async {
                            print("All Items loaded. Starting the list \(items).")
                            self?.allItems = items
                            self?.loadingState = .success
                        }
                    }
                }
            }
    }
}


