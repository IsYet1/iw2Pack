//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    
    var curEventId: String
    @State private var curItem: Item
    
    @EnvironmentObject var store: Store<AppState>
    var packStateManager = PackStateManager()
    
    init(item: Item, eventId: String) {
        curItem = item
        curEventId = eventId
    }
    
    var body: some View {
        let packAppState = packStateManager.map(state: store.state.packAuthState)
        HStack {
            Toggle(
                curItem.name!,
                isOn: Binding<Bool>(
                    get: { if let itemPacked = curItem.packed {return itemPacked} else {return false} },
                    set: {
//                        print("Value \($0) \(curItem)")
                        curItem.packed = $0
                        packAppState.setPackedState($0, curItem, curEventId, store)
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
