//
//  PackAppStateManager.swift
//  iw2Pack
//
//  Created by Don McKenzie on 22-Feb-22.
//

import Foundation

class PackStateManager {
    struct Props {
        let allItemsDict: [String: Item]
        let setPackedState: (Bool, Item, String, Store<AppState>) -> Void
        let setSelected: ( Bool, String, Store<AppState> ) -> Void
    }
    func map(state: PackState) -> Props {
        return Props(
            allItemsDict: state.allItemsDict,
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
            }
        )
    }
 
}
