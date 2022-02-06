//
//  PackMiddleWares.swift
//  iw2Pack
//
//  Created by Don McKenzie on 05-Feb-22.
//

import Foundation
import Firebase

func login(email: String, password: String) -> Void {
    Auth.auth().signIn(withEmail: email.lowercased(), password: password) { (result, error) in
        if let error = error {
            print("EFFECT LOGIN FAILED!! : \(error.localizedDescription)")
        } else {
            print("EFFECT LOGIN SUCCESS :-) :")
        }
    }
}

func packMiddleware() -> Middleware<AppState> {
    return {state, action, dispatch in
        switch action {
        case let action as PackAttemptLogin:
            print("Login attempt \(action)")
            DispatchQueue.main.asyncAfter (deadline: .now() + 2.0) {
                Auth.auth().signIn(withEmail: action.email.lowercased(), password: action.password) { (result, error) in
                    if let error = error {
                        print("EFFECT LOGIN FAILED!! : \(error.localizedDescription)")
                        dispatch(PackSetAuthStatus(authStatus: false))
                    } else {
                        print("EFFECT LOGIN SUCCESS :-) :")
                        dispatch(PackSetAuthStatus(authStatus: true))
                    }
                }
                
            }
        default:
            break
        }
    }
}

