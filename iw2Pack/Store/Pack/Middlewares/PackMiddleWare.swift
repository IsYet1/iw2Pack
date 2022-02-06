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
                        dispatch(PackAllItems_Get())
                    case .failure(let error):
                        print("Login Error: \(error.localizedDescription)")
                        dispatch(PackSetAuthStatus(authStatus: false))
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
                        dispatch(PackAllItems_Store(allItems: []))
                }
                
            }
           
        default:
            break
        }
    }
}

