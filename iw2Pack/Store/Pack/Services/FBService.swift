//
//  FBService.swift
//  iw2Pack
//
//  Created by Don McKenzie on 06-Feb-22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

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
    
    // Deprecated. Using dictionary instead as of 6-Feb. Leaving in in case it's useful logic.
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
                                return  item
                            }
                            return nil
                        }
                       completion(.success(items))
                    }
                }
            }
 
    }
    /*
    func addItemToStore(storeId: String, eventItem: EventItem, completion: @escaping (Result<Bool?, Error>) -> Void) {
        do {
            let _ = try db.collection("pack").document("data").collection("lists").document("ohio").collection("items")
                .document("0DvXrq5LXfi08PW0D0ol").setData(["packed": true])
                // TODO: Try using the storeItem object instead of parsing it out.
            
            self.getStoreById(storeId: storeId) { result in
                switch result{
                case .success(let store):
                    completion(.success(store))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    */
 
    
    func getEventItems(eventId: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        db.collection("pack").document("data").collection("lists").document(eventId).collection("items")
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
                                return  item
                            }
                            return nil
                        }
                       completion(.success(items))
                    }
                }
            }
    }
 
    
    func getAllEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        db.collection("pack").document("data").collection("lists")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let events: [Event] = snapshot.documents.compactMap {doc in
                            var event = try? doc.data(as: Event.self)
                            event?.id = doc.documentID
                            if let event = event {
                                return  event
                            }
                            return nil
                        }
                       completion(.success(events))
                    }
                }
            }
 
    }
 
    
    func getAllItemsDict(completion: @escaping (Result<[String: Item], Error>) -> Void) {
        db.collection("pack").document("data").collection("items")
            .getDocuments { snapshot, error in
                if let error = error {
//                    print(error.localizedDescription)
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let items: [Item] = snapshot.documents.compactMap {doc in
                            var item = try? doc.data(as: Item.self)
                            item?.id = doc.documentID
                            if let item = item {
                                return  item
                            }
                            return nil
                        }
                        var itemsDict: [String: Item] = [ : ]
                        items.forEach {item in itemsDict[item.id!] = item }
//                        let itemsDict = items.map { item in
//                          return item.id: item
//                        }
//                        print("Items Dictionary: \(itemsDict)")
                        completion(.success(itemsDict))
                    }
                }
            }
 
    }
 
    

}

