//
//  FBService.swift
//  iw2Pack
//
//  Created by Don McKenzie on 06-Feb-22.
//

import Foundation
import Firebase

class FBService {
    let db = Firestore.firestore()
    
    func login( email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        print(email, password)
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func getAllItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        db.collection("pack").document("data").collection("items")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let items: [Item] = snapshot.documents.compactMap {doc in
                            var item = try? doc.data(as: Item.self)
                            item?.id = doc.documentID
                            if let item = item {
//                                self?.allItemsDict[doc.documentID] = try? doc.data(as: Item.self)
                                return  item
//                                return ItemViewModel(item: item)
                            }
                            return nil
                        }
                        // self must be ? here because it might be nil
                        completion(.success(items))
                    }
                }
            }
 
    }
    

}

