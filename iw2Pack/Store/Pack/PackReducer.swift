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
        case let action as PackAllItems_Store:
            state.allItems = action.allItems
        case let action as PackAllItemsDict_Store:
            state.allItemsDict = action.allItems
        default:
            break
   }
//   print(state)
   return state
}
