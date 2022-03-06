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
    var dbRef_GlobalItemsCollection: CollectionReference
    var dbRef_EventsCollection: CollectionReference
    var dbRef_MetaDocument: DocumentReference
    
    init() {
        let rootCollection = "pack1"
        dbRef_GlobalItemsCollection = db.collection(rootCollection).document("data").collection("items")
        dbRef_EventsCollection = db.collection(rootCollection).document("data").collection("lists")
        dbRef_MetaDocument = db.collection(rootCollection).document("meta")
    }
    
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
    
    func deleteGlobalItem(id: String, completion: @escaping (Result<String, Error>) -> Void) {
        let globalItemListRef = dbRef_GlobalItemsCollection
            globalItemListRef.document(id).delete() { err in
                if let err = err {
                    print("Error deleting the item from the event: \(err)")
                    completion(.failure(err))
                } else {
                    completion(.success("Item /(id) deleted"))
                }
            }
    }
    
    func addGlobalItem(itemToAdd: ItemToAdd, completion: @escaping (Result<ItemToAdd, Error>) -> Void) {
        let globalItemListRef = dbRef_GlobalItemsCollection
        do {
            var ref: DocumentReference? = nil
            ref = try globalItemListRef.addDocument(from: itemToAdd) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(.failure(err))
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    var addedItem = itemToAdd
                    addedItem.id = ref!.documentID
                    completion(.success(addedItem))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    func updateGlobalItem(item: ItemUpdate, completion: @escaping (Result<Bool?, Error>) -> Void) {
        let ref = dbRef_GlobalItemsCollection.document(item.id)
        
        ref.updateData(["name": item.name as String, "category": item.category as String, "location": item.location as String]) {error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    
    func updateEventItemPackedState(eventItem: EventItem, packed: Bool, completion: @escaping (Result<Bool?, Error>) -> Void) {
        let ref = dbRef_EventsCollection.document(eventItem.eventId).collection("items")
            .document(eventItem.itemId)
        
        ref.updateData(["packed": packed as Bool]) {error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    
    func getEventItems(eventId: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        dbRef_EventsCollection.document(eventId).collection("items")
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
    
    func getCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        dbRef_MetaDocument.collection("categories")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                } else {
                    // TODO: Add a category model and get the remaining location data
                    if let snapshot = snapshot {
                        let categories: [String] = snapshot.documents.compactMap {doc in
                            return doc.documentID
                        }
                        completion(.success(categories))
                    }
                }
            }
    }
    
    func getLocations(completion: @escaping (Result<[String], Error>) -> Void) {
        dbRef_MetaDocument.collection("locations")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                } else {
                    // TODO: Add a locations model and get the remaining location data
                    if let snapshot = snapshot {
                        let locations: [String] = snapshot.documents.compactMap {doc in
                            return doc.documentID
                        }
                        completion(.success(locations))
                    }
                }
            }
    }
    
    func getAllEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        dbRef_EventsCollection
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
        dbRef_GlobalItemsCollection
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
    
    func deleteItemsFromEvent(eventId: String, eventItemIds: [String], completion: @escaping (Result<String, Error>) -> Void) {
        let eventItemListRef = dbRef_EventsCollection.document(eventId).collection("items")
        eventItemIds.forEach() {
            let curEventItemIdToDelete = $0
            eventItemListRef.document(curEventItemIdToDelete).delete() { err in
                if let err = err {
                    print("Error deleting the item from the event: \(err)")
                    completion(.failure(err))
                } else {
                    completion(.success(curEventItemIdToDelete))
                }
            }
        }
    }
    
    func addItemsToEvent(eventId: String, eventItemIds: [String], completion: @escaping (Result<Item, Error>) -> Void) {
        let itemsToAdd = eventItemIds.map({ ItemToAddToEventList(itemId: $0, packed: false, staged: false) })
        let eventItemListRef = dbRef_EventsCollection.document(eventId).collection("items")
        itemsToAdd.forEach() {
            let curItemToAdd = $0
            do {
                var ref: DocumentReference? = nil
                ref = try eventItemListRef.addDocument(from: curItemToAdd) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        completion(.failure(err))
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        //                        curItemToAdd.id = ref!.documentID
                        completion(.success(Item(id: ref!.documentID, itemId: curItemToAdd.itemId, packed: false, staged: false)))
                    }
                }
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    // Deprecated. Using dictionary instead as of 6-Feb. Leaving in in case it's useful logic.
    func getAllItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        dbRef_GlobalItemsCollection
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
}

