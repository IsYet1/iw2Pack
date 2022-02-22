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
    }
    func map(state: PackState) -> Props {
        return Props(
            allItemsDict: state.allItemsDict,
            setPackedState: {
                if let itemId = $1.id {
                    let eventItemForPackAction1 = EventItem(eventId: $2, itemId: itemId)
                    $3.dispatch(action: PackSetPackedState(eventItem: eventItemForPackAction1, packedBool: $0) )
                } else {
                    print ("Is itemId nil?")
                }
            }
        )
    }
 
}
