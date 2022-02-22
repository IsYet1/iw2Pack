//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct AllItemCell: View {
    
    @State private var curItem: Item
    
    @EnvironmentObject var store: Store<AppState>
    var packStateManager = PackStateManager()
 
    init(item: Item) {
        curItem = item
    }
    
    var body: some View {
        let packAppState = packStateManager.map(state: store.state.packAuthState)
        HStack {
            Toggle(
                curItem.name!,
                isOn: Binding<Bool>(
                    get: { if let itemSelected = curItem.selected {return itemSelected} else {return false} },
                    set: {
                        curItem.selected = $0
                        print("Value \($0) \(curItem)")
//                        store.dispatch(action: PackSetItemSelected(itemId: curItem.id!, selected: $0))
                        packAppState.setSelected($0, curItem.id!, store)
                    }
                )
            )
                .toggleStyle(CheckboxToggleStyle(style: .circle))
                .foregroundColor(.blue)
        }
   }
}

struct AllItemCell_Previews: PreviewProvider {
    static var previews: some View {
        AllItemCell(item: Item(id: "Id", name: "Preview Item",  itemId: "item id here", packed: true))
//        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
