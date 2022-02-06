//
//  PackMiddleWares.swift
//  iw2Pack
//
//  Created by Don McKenzie on 05-Feb-22.
//

import Foundation
import Firebase

func login(email: String, password: String, completion: @escaping () -> Void) {
    Auth.auth().signIn(withEmail: email.lowercased(), password: password) { (result, error) in
        if let error = error {
            print("LOGIN FAILED!! : \(error.localizedDescription)")
        } else {
            print("LOGIN SUCCESS :-) :")
            completion()
        }
    }
}

func packMiddleware() -> Middleware<AppState> {
    return {state, action, dispatch in
        switch action {
            case _ as PackAttemptLogin:
                print("Login attempt \(action)")
                DispatchQueue.main.asyncAfter (deadline: .now() + 2.0) {
                    dispatch(PackSetAuthStatus(authStatus: true))
            }
            default:
                break
        }
    }
}

