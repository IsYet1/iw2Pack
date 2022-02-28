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
            
        case let action as PackUpdateGlobalItem:
            FBService().updateGlobalItem(item: action.item) { result in
                switch result {
                case .success(_):
                    print ("Item Updated")
                    dispatch(PackUpdateGlobalItem_Local(item: action.item))
                case .failure(let error):
                    print ("DID NOT UPDATE item \(error.localizedDescription)")
                }
            }
            
        case let action as PackDeleteItemsFromEvent:
            FBService().deleteItemsFromEvent(eventId: action.eventId, eventItemIds: action.itemIds) {result in
                switch result {
                case .success(let removedEventItemId):
                    print ("Removed items to the event")
                    dispatch(PackRemoveItemFromLocalEventList(eventItemId: removedEventItemId ))
                case .failure(let error):
                    print ("DID NOT REMOVE items from the event \(error.localizedDescription)")
                }
                
            }
            
        case let action as PackAddItemsToEvent:
            FBService().addItemsToEvent(eventId: action.eventId, eventItemIds: action.itemIds) {result in
                switch result {
                case .success(let itemsAddedToEvent):
                    print ("Added items to the event")
                    print (itemsAddedToEvent)
                    let allItemsHash = state.packAuthState.allItemsDict
                    let eventItemForDispatch = getItemDetailsForEventItem(eventItem: itemsAddedToEvent, allItemsHash: allItemsHash)
                    dispatch(PackAddEventItemToLocalEventList(eventItem: eventItemForDispatch ))
                    dispatch(PackSetItemSelected(itemId: itemsAddedToEvent.itemId!, selected: false))
                case .failure(let error):
                    print ("Added NOT items to the event \(error.localizedDescription)")
                }
                
            }
            
        case let action as PackSetPackedState:
            print("Set Pack state \(action)")
            
            if let packedBool = action.packedBool {
                FBService().updateEventItemPackedState( eventItem: action.eventItem, packed: packedBool) {result in
                    switch result {
                    case .success(_):
                        dispatch(PackEventItems_Get(eventId: action.eventItem.eventId))
                    case .failure(let error):
                        print("Set packed status failed: \(error.localizedDescription)")
                    }
                }
                
            } else {
                print("Packed boolean not provided in the action")
            }
            
        case let action as PackAttemptLogin:
            print("Login attempt \(action)")
            
            FBService().login(email: action.email, password: action.password) {result in
                switch result {
                case .success(let loggedin):
                    dispatch(PackSetAuthStatus(authStatus: loggedin))
                    dispatch(PackAllItemsDict_Get())
                    dispatch(PackAllEvents_Get())
                    dispatch(PackLocations_Get())
                    dispatch(PackCategories_Get())
                case .failure(let error):
                    print("Login Error: \(error.localizedDescription)")
                    dispatch(PackSetAuthStatus(authStatus: false))
                }
                
            }
            
        case let action as PackAllItemsDict_Get:
            print("Get All Items \(action)")
            
            FBService().getAllItemsDict() {result in
                switch result {
                case .success(let allItems):
                    dispatch(PackAllItemsDict_Store(allItems: allItems))
                case .failure(let error):
                    print("Get all items Error: \(error.localizedDescription)")
                    dispatch(PackAllItemsDict_Store(allItems: [ : ]))
                }
                
            }
            
        case let action as PackAllItems_Get:
            print("Get All Items \(action)")
            
            FBService().getAllItems() {result in
                switch result {
                case .success(let allItems):
                    dispatch(PackAllItems_Store(allItems: allItems))
                case .failure(let error):
                    print("Get all items Error: \(error.localizedDescription)")
                    dispatch(PackAllItems_Store(allItems: [ ]))
                }
                
            }
            
        case let action as PackCategories_Get:
            print("Get All Categories \(action)")
            
            FBService().getCategories() {result in
                switch result {
                case .success(let categories):
                    dispatch(PackCategories_Store(categories: categories))
                case .failure(let error):
                    print("Get Locations Error: \(error.localizedDescription)")
                    dispatch(PackCategories_Store(categories: [ ]))
                }
            }
            
         case let action as PackLocations_Get:
            print("Get All Locations \(action)")
            
            FBService().getLocations() {result in
                switch result {
                case .success(let locations):
                    dispatch(PackLocations_Store(locations: locations))
                case .failure(let error):
                    print("Get Locations Error: \(error.localizedDescription)")
                    dispatch(PackLocations_Store(locations: [ ]))
                }
            }
            
        case let action as PackAllEvents_Get:
            print("Get All Events \(action)")
            
            FBService().getAllEvents() {result in
                switch result {
                case .success(let allEvents):
                    dispatch(PackAllEvents_Store(allEvents: allEvents))
                case .failure(let error):
                    print("Get all items Error: \(error.localizedDescription)")
                    dispatch(PackAllEvents_Store(allEvents: [ ]))
                }
            }
            
        case let action as PackEventItems_Get:
            FBService().getEventItems(eventId: action.eventId) {result in
                switch result {
                case .success(let eventItems):
                    let allItemsHash = state.packAuthState.allItemsDict
                    let rtnItems: [Item] = eventItems.map{eventItem in
                        return getItemDetailsForEventItem(eventItem: eventItem, allItemsHash: allItemsHash)
                    }
                    dispatch(PackEventItems_Store(eventItems: rtnItems))
                    
                case .failure(let error):
                    print("Get all items Error: \(error.localizedDescription)")
                    dispatch(PackEventItems_Store(eventItems: []))
                }
            }
        default:
            break
        }
    }
}

func getItemDetailsForEventItem(eventItem: Item, allItemsHash: [String: Item]) -> Item {
    var item = eventItem
    if let itemId = item.itemId, let allItemData = allItemsHash[itemId] {
        item.name = allItemData.name
        item.category = allItemData.category
        item.location = allItemData.location
    } else {
        item.name = "No Item: \(item.id!)" //"itemId!)"
        item.category = "Item Not Found"
    }
    return item
}

