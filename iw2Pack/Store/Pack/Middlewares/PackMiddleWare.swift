//
//  PackMiddleWares.swift
//  iw2Pack
//
//  Created by Don McKenzie on 05-Feb-22.
//

import Foundation
import Firebase

func packMiddleware() -> Middleware<AppState> {
    return {state, action, dispatch in
        switch action {
        case let action as PackAttemptLogin:
            print("Login attempt \(action)")
            
            FBService().login(email: action.email, password: action.password) {result in
                switch result {
                    case .success(let loggedin):
                        dispatch(PackSetAuthStatus(authStatus: loggedin))
                        dispatch(PackAllItemsDict_Get())
                        dispatch(PackAllEvents_Get())
                    case .failure(let error):
                        print("Login Error: \(error.localizedDescription)")
                        dispatch(PackSetAuthStatus(authStatus: false))
                }
                
            }
            
        case let action as PackAllItemsDict_Get:
            print("Get All Items \(action)")
            
            FBService().getAllItemsDict() {result in
                switch result {
                    case .success(let allItems):
                        dispatch(PackAllItemsDict_Store(allItems: allItems))
                    case .failure(let error):
                        print("Get all items Error: \(error.localizedDescription)")
                        dispatch(PackAllItemsDict_Store(allItems: [ : ]))
                }
                
            }
            
        case let action as PackAllItems_Get:
            print("Get All Items \(action)")
            
            FBService().getAllItems() {result in
                switch result {
                    case .success(let allItems):
                        dispatch(PackAllItems_Store(allItems: allItems))
                    case .failure(let error):
                        print("Get all items Error: \(error.localizedDescription)")
                        dispatch(PackAllItems_Store(allItems: [ ]))
                }
                
            }
        
        case let action as PackAllEvents_Get:
            print("Get All Events \(action)")
            
            FBService().getAllEvents() {result in
                switch result {
                    case .success(let allEvents):
                        dispatch(PackAllEvents_Store(allEvents: allEvents))
                    case .failure(let error):
                        print("Get all items Error: \(error.localizedDescription)")
                        dispatch(PackAllEvents_Store(allEvents: [ ]))
                }
                
            }
 
        case let action as PackEventItems_Get:
            print("Get Event Items \(action)")
            
            FBService().getEventItems(eventId: action.eventId) {result in
                switch result {
                    case .success(let eventItems):
                        dispatch(PackEventItems_Store(eventItems: eventItems))
                    case .failure(let error):
                        print("Get all items Error: \(error.localizedDescription)")
                        dispatch(PackEventItems_Store(eventItems: []))
                }
                
            }
        
 
        default:
            break
        }
    }
}

