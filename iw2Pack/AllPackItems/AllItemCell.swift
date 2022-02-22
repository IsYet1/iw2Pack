//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct AllItemCell: View {
    
    @EnvironmentObject var store: Store<AppState>
    @State private var curItem: Item
    
    struct PackAppState {
    }
    private func map(state: PackState) -> PackAppState {
        return PackAppState(

        )
    }
 
    init(item: Item) {
        curItem = item
    }
    
    var body: some View {
        let packAppState = map(state: store.state.packAuthState)
        HStack {
            Toggle(
                curItem.name!,
                isOn: Binding<Bool>(
                    get: { if let itemSelected = curItem.selected {return itemSelected} else {return false} },
                    set: {
                        print("Value \($0) \(curItem)")
                        curItem.selected = $0
//                        packAppState.setPackedState($0, curItem)
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
