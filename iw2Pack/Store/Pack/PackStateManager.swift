//
//  PackAppStateManager.swift
//  iw2Pack
//
//  Created by Don McKenzie on 22-Feb-22.
//

import Foundation

class PackStateManager {
    struct Props {
        let allEvents: [ Event ]
        let allItemsByLocation: [(key: String, value: [Item] ) ]
        let allItemsByCategory: [(key: String, value: [Item] ) ]
        let allItemsDict: [String: Item]
        let categories: [String]
        let eventItems: [ Item ]
        let locations: [String]
        let loggedIn: Bool
        let selectedAllItemIds: () -> [String]
        
        let addItemsToEvent: (Store<AppState>, String, [String]) -> Void
        let addGlobalItem: (Store<AppState>, ItemToAdd) -> Void
        let attemptLogin: (Store<AppState>, String, String) -> Void
        let deleteGlobalItem: (Store<AppState>, String) -> Void
        let deleteItemsFromEvent: (Store<AppState>, String, [String]) -> Void
        let getItemsForEvent: (Store<AppState>, String) -> Void
        let loadAllItems: (Store<AppState>) -> Void
        let loadEventItems: (Store<AppState>, String) -> Void
        let setPackedState: (Bool, Item, String, Store<AppState>) -> Void
        let setSelected: ( Bool, String, Store<AppState> ) -> Void
        let updateGlobalItem: (Store<AppState>, ItemUpdate) -> Void
    }
    func map(state: PackState) -> Props {
        return Props(
            allEvents: state.allEvents,
            allItemsByLocation: groupItems(itemsDictionary: state.allItemsDict, byLocation: true),
            allItemsByCategory: groupItems(itemsDictionary: state.allItemsDict, byLocation: false),
            allItemsDict: state.allItemsDict,
            categories: state.categories,
            eventItems: state.eventItems,
            locations: state.locations,
            loggedIn: state.loggedIn,
            selectedAllItemIds: {
                let selectedItems = state.allItemsDict.filter({key, value in
                    if let selected = value.selected {
                        return selected
                    } else {
                        return false
                    }
                })
                return Array(selectedItems.keys)
            },
            
            addItemsToEvent: {
                let store = $0
                let eventId = $1
                let itemIds = $2
                store.dispatch(action: PackAddItemsToEvent(eventId: eventId, itemIds: itemIds))
            },
            addGlobalItem: {
                let store = $0
                let itemToAdd = $1
                store.dispatch(action: PackAddGlobalItem(item: itemToAdd))
            },
            
            attemptLogin: { $0.dispatch(action: PackAttemptLogin(email: $1, password: $2))},
            deleteGlobalItem: {
                let store = $0
                let id = $1
                store.dispatch(action: PackDeleteGlobalItem(id: id))
            },
            deleteItemsFromEvent: {
                let store = $0
                let eventId = $1
                let itemIds = $2
                store.dispatch(action: PackDeleteItemsFromEvent(eventId: eventId, itemIds: itemIds))
            },
            getItemsForEvent: {
                let store = $0
                let eventId = $1
                store.dispatch(action: PackEventItems_Get(eventId: eventId))
            },
            loadAllItems: {
                let store = $0
                store.dispatch(action: PackAllItemsDict_Get())
            },
            loadEventItems: {
                let store = $0
                let eventId = $1
                store.dispatch(action: PackEventItems_Get(eventId: eventId))
            },
            setPackedState: {
                let packed = $0
                let item = $1
                let eventId = $2
                let store = $3
                if let itemId = item.id {
                    let eventItemForPackAction1 = EventItem(eventId: eventId, itemId: itemId)
                    store.dispatch(action: PackSetPackedState(eventItem: eventItemForPackAction1, packedBool: packed) )
                } else {
                    print ("Is itemId nil?")
                }
            },
            setSelected: {
                let selected = $0
                let itemId = $1
                let store = $2
                store.dispatch(action: PackSetItemSelected(itemId: itemId, selected: selected))
            },
            updateGlobalItem: {
                let store = $0
                let item = $1
                store.dispatch(action: PackUpdateGlobalItem(item: item))
            }
        )
    }
    
    private func groupItems(itemsDictionary: [String : Item], byLocation: Bool) -> [(key: String, value: [Item] ) ]  {
        let items = itemsDictionary.values
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name ?? "___ no name" < $1.name ?? "___ no name" })
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { packItem in
                return byLocation
                ? packItem.location ?? "___ LOCATION not set"
                : packItem.category ?? "___ CATEGORY not set"
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
}
