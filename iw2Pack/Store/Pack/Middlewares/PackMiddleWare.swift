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
                    case .failure(let error):
                        print("Login Error: \(error.localizedDescription)")
                        dispatch(PackSetAuthStatus(authStatus: false))
                }
                
            }
           
        default:
            break
        }
    }
}

