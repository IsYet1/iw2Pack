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
            
            FBService().login1(email: action.email, password: action.password) {result in
                switch result {
                case .success(let loggedin):
                    dispatch(PackSetAuthStatus(authStatus: loggedin))
                case .failure(let error):
                    print("Login Error: \(error)")
                    dispatch(PackSetAuthStatus(authStatus: false))
                }
                
            }
            
//            if FBService().login(email: action.email, password: action.password) {
//                dispatch(PackSetAuthStatus(authStatus: true))
//            } else {
//                dispatch(PackSetAuthStatus(authStatus: false))
//            }
//            Auth.auth().signIn(withEmail: action.email.lowercased(), password: action.password) { (result, error) in
//                if let error = error {
//                    print("EFFECT LOGIN FAILED!! : \(error.localizedDescription)")
//                    dispatch(PackSetAuthStatus(authStatus: false))
//                } else {
//                    print("EFFECT LOGIN SUCCESS :-) :")
//                    dispatch(PackSetAuthStatus(authStatus: true))
//                }
//            }
            
        default:
            break
        }
    }
}

