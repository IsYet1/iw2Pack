//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    let item: Item1
    
    @EnvironmentObject var store: Store<AppState>
    struct Props {
        let allItemsDict: [String: Item]
        let attemptLogin: (String, String) -> Void
    }
    private func map(state: PackState) -> Props {
        return Props(allItemsDict: state.allItemsDict,
             attemptLogin: { store.dispatch(action: PackAttemptLogin(email: $0, password: $1))}
                     
        )
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
//            Text(item.itemId)
            Text(getItemName(itemId:item.itemId!, allItemsDict: props.allItemsDict))
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: Item1(id: "Id", name: "Preview Item", packed: true, itemId: "item id here"))
//        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
