//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct AllItemsCell: View {
    
    @State private var curItem: Item
    
    init(item: Item) {
        curItem = item
    }
    
    var body: some View {
        HStack {
            Text(
                curItem.name!
            )
        }
   }
}

struct AllItemsCell_Previews: PreviewProvider {
    static var previews: some View {
        AllItemsCell(item: Item(id: "Id", name: "Preview Item",  itemId: "item id here", packed: true))
//        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
