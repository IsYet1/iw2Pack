//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemCell: View {
    let item: ItemViewModel
    
    var body: some View {
        HStack {
            Text(item.itemId)
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
