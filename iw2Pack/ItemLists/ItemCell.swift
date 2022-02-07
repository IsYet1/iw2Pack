//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    @StateObject private var allItemsListVM = AllItemsListViewModel()
    let item: ItemViewModel
    
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
        let item = allItemsListVM.allItemsDict[itemId, default: Item(name: "Not Found HERE", itemId: "0000")]
        let dictName = allItemsDict[itemId]?.name
        return dictName!
        if let name = item.name {
            return name
        } else {
            return "Not Found Here"
        }
    }
    
    var body: some View {
        let props = map(state: store.state.packAuthState)
        HStack {
//            Text(item.itemId)
            Text(getItemName(itemId:item.itemId, allItemsDict: props.allItemsDict))
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
