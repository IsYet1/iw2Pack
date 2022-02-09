//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    let item: Item
    
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
 
    @State private var isOn = true
    
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
            Toggle(
                getItemName(itemId:item.itemId!, allItemsDict: props.allItemsDict),
//                "Checkbox 1",
                isOn: $isOn
            )
              .toggleStyle(CheckboxToggleStyle(style: .circle))
              .foregroundColor(.blue)
//            Text(getItemName(itemId:item.itemId!, allItemsDict: props.allItemsDict))
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: Item(id: "Id", name: "Preview Item"))
//        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
