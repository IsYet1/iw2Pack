//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    
    @EnvironmentObject var store: Store<AppState>
    @State private var curItem: Item
    
    struct Props {
        let allItemsDict: [String: Item]
        let attemptLogin: (String, String) -> Void
    }
    private func map(state: PackState) -> Props {
        return Props(allItemsDict: state.allItemsDict,
             attemptLogin: { store.dispatch(action: PackAttemptLogin(email: $0, password: $1))}
                     
        )
    }
 
    init(item: Item) {
        curItem = item
    }
    
    private func getItemName(itemId: String, allItemsDict: [String: Item]) -> String {
        if let dictItem = allItemsDict[itemId] {
            return dictItem.name!
        } else {
            return itemId
        }
    }
    
    var body: some View {
        let props = map(state: store.state.packAuthState)
        HStack {
            Toggle(
                getItemName(itemId:curItem.itemId!, allItemsDict: props.allItemsDict),
                isOn: Binding<Bool>(
                    get: { if let itemPacked = curItem.packed {return itemPacked} else {return false} },
                    set: {
                        print("Value \($0)")
                        curItem.packed = $0
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
        ItemCell(item: Item(id: "Id", name: "Preview Item",  itemId: "item id here", packed: true))
//        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
