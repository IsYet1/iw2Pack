//
//  LoginViewModel.swift
//  U_FungiFinder
//
//  Created by Don McKenzie on 11/26/21.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    var email: String = ""
    var password: String = ""
    
    func login(completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { (result, error) in
            if let error = error {
                print("LOGIN FAILED!! : \(error.localizedDescription)")
            } else {
                print("LOGIN SUCCESS :-) :")
                completion()
            }
        }
    }
}

