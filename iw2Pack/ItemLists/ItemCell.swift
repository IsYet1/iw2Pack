//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    let item: Item
    @State private var isOn = true
    @State private var itemPacked = true
    @EnvironmentObject var store: Store<AppState>
    
    struct Props {
        let allItemsDict: [String: Item]
    }
    private func map(state: PackState) -> Props {
        return Props(
            allItemsDict: state.allItemsDict
        )
    }
 
    private func getItemName(itemId: String, allItemsDict: [String: Item]) -> String {
        if let dictItem = allItemsDict[itemId] {
//            isOn = false
            return dictItem.name!
        } else {
            return itemId
        }
    }
     private func getItemPacked(item: Item) -> Bool {
         if let packed = item.packed {
            isOn = packed
            return packed
        } else {
            return false
        }
    }
    
    var body: some View {
        let props = map(state: store.state.packAuthState)
        HStack {
            Toggle(
                getItemName(itemId:item.itemId!, allItemsDict: props.allItemsDict),
                isOn: $isOn
//                isOn: getItemPacked(item: item) // $isOn
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
