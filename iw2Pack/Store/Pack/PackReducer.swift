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
    case let action as PackSetItemSelected:
        // TODO: Change this to not mutate state. Should be setting state to the result, not updating it.
        state.allItemsDict[action.itemId]?.selected = action.selected
    case let action as PackUpdateGlobalItem_Local:
        // TODO: Convert this directly instead of setting the indivdual properties. Cast it, etc.
        state.allItemsDict[action.item.id] = Item(id: action.item.id, name: action.item.name, category: action.item.category, location: action.item.location)
        
    case let action as PackSetAuthStatus:
        state.loggedIn = action.authStatus
    case let action as PackAllItems_Store:
        state.allItems = action.allItems
    case let action as PackAllItemsDict_Store:
        state.allItemsDict = action.allItems
    case let action as PackAllEvents_Store:
        state.allEvents = action.allEvents
    case let action as PackEventItems_Store:
        state.eventItems = action.eventItems
    case let action as PackRemoveItemFromLocalEventList:
        state.eventItems = state.eventItems.filter() {$0.id != action.eventItemId}
    case let action as PackAddEventItemToLocalEventList:
        state.eventItems = state.eventItems + [action.eventItem]
    case let action as PackLocations_Store:
        state.locations = action.locations
    default:
        break
   }
//   print(state)
   return state
}
