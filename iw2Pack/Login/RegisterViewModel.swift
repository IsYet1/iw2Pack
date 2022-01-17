//
//  RegisterViewModel.swift
//  U_FungiFinder
//
//  Created by Don McKenzie on 11/26/21.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    var email: String = ""
    var password: String = ""
    
    func register(completion: @escaping() -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion()
            }
        }
    }
}
