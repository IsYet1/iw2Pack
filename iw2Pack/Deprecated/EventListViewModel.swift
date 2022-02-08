//
//  EventListViewModel.swift
//  iw2Pack
//
//  Created by Don McKenzie on 24-Jan-22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class EventListViewModel: ObservableObject {
    let db = Firestore.firestore()
    @Published var events: [EventViewModel] = []
    @Published var loadingState: LoadingState = .idle
    
    func getAllEvents() {
        DispatchQueue.main.async {
            self.loadingState = .loading
        }
        
        db.collection("pack").document("data").collection("lists")
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.loadingState = .failure
                    }
                } else {
                    if let snapshot = snapshot {
                        let events: [EventViewModel] = snapshot.documents.compactMap {doc in
                            var event = try? doc.data(as: Event.self)
                            event?.id = doc.documentID
                            if let event = event {
//                                print("Event found in the loop: \(event)")
                                return EventViewModel(event: event)
                            }
                            return nil
                        }
                        DispatchQueue.main.async {
//                            print("Events loaded. Starting the Event List")
                            self?.events = events
                            self?.loadingState = .success
                        }
                    }
                }
            }
    }
    
}
