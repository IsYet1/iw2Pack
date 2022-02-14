//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    
    var curEventId: String
    @EnvironmentObject var store: Store<AppState>
    @State private var curItem: Item
    
    struct PackAppState {
        let allItemsDict: [String: Item]
        let attemptLogin: (String, String) -> Void
        let setPackedState: (Bool, Item) -> Void
    }
    private func map(state: PackState) -> PackAppState {
        return PackAppState(
            allItemsDict: state.allItemsDict,
            attemptLogin: { store.dispatch(action: PackAttemptLogin(email: $0, password: $1))},
            setPackedState: {
                let eventItemForPackAction1 = EventItem(eventId: curEventId, itemId: $1.id!)
                store.dispatch(action: PackSetPackedState(eventItem: eventItemForPackAction1, packedBool: $0)
            )}
        )
    }
 
    init(item: Item, eventId: String) {
        curItem = item
        curEventId = eventId
    }
    
    private func getItemName(itemId: String, allItemsDict: [String: Item]) -> String {
        if let dictItem = allItemsDict[itemId] {
            return dictItem.name!
        } else {
            return itemId
        }
    }
    
    var body: some View {
        let packAppState = map(state: store.state.packAuthState)
        HStack {
            Toggle(
                getItemName(itemId:curItem.itemId!, allItemsDict: packAppState.allItemsDict),
                isOn: Binding<Bool>(
                    get: { if let itemPacked = curItem.packed {return itemPacked} else {return false} },
                    set: {
                        print("Value \($0) \(curItem)")
                        curItem.packed = $0
                        packAppState.setPackedState($0, curItem)
                    }
                )
            )
                .toggleStyle(CheckboxToggleStyle(style: .circle))
                .foregroundColor(.blue)
        }
   }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: Item(id: "Id", name: "Preview Item",  itemId: "item id here", packed: true), eventId: "Event Id")
//        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
