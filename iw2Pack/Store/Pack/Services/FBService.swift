//
//  FBService.swift
//  iw2Pack
//
//  Created by Don McKenzie on 06-Feb-22.
//

import Foundation
import Firebase

class FBService {
    func login(email: String, password: String) -> Bool {
        var loginResults: Bool = true
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { (result, error ) in
            if let error = error {
                print("EFFECT LOGIN FAILED!! : \(error.localizedDescription)")
                loginResults = false
            } else {
                print("EFFECT LOGIN SUCCESS :-) : \(result!.user)")
                loginResults = true
            }
        }
        return loginResults
    }
    func login1( email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        print(email, password)
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { (result, error) in
            if let error = error {
                print("LOGIN FAILED!! : \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("LOGIN SUCCESS :-) :")
                completion(.success(true))
            }
        }
    }
    

}

