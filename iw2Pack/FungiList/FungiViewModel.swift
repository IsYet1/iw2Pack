//
//  FungiViewModel.swift
//  U_FungiFinder
//
//  Created by Don McKenzie on 11/30/21.
//

import Foundation

struct FungiViewModel {
    let fungi: Fungi
    
    var fungiId: String {
        fungi.id ?? ""
    }
    
    var name: String {
        fungi.name
    }
    
    var photoUrl: String {
        fungi.photoUrl
    }
}

