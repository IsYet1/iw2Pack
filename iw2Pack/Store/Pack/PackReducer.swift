//
//  AuthState.swift
//  iw2Pack
//
//  Created by Don McKenzie on 05-Feb-22.
//

import Foundation

func packReducer(_ state: PackState, _ action: Action) -> PackState {
    
    var state = state
    
    switch action {
        case let action as PackSetAuthStatus:
            state.loggedIn = action.authStatus
        default:
            break
   }
   print(state)
   return state
}
