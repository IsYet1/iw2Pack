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
    
    private func getItemName(itemId: String) -> String {
        let item = allItemsListVM.allItemsDict[itemId, default: Item(name: "Not Found HERE", itemId: "0000")]
        if let name = item.name {
            return name
        } else {
            return "Not Found Here"
        }
    }
    
    var body: some View {
        HStack {
            Text(getItemName(itemId:item.itemId))
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
