//
//  ItemCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct AllItemsCell: View {
    
    @State private var curItem: Item
    @State private var itemName: String
    @State private var itemCategory: String
    @State private var itemLocation: String
    
    init(item: Item) {
        curItem = item
        if let value = item.name { itemName = value } else {itemName = "Name Not Set"}
        if let value = item.category { itemCategory = value } else {itemCategory = "Category Not Set"}
        if let value = item.location { itemLocation = value } else {itemLocation = "Location Not Set"}
    }
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: EditItemDetails(packItem: curItem),
                label: {
                    VStack {
                        HStack {
                            Text(itemName).font(.callout)
                            Spacer()
                        }
                        .padding([.leading, .trailing],  10)
                        HStack {
                            Text(itemCategory).font(.caption2)
                            Spacer()
                            Text(itemLocation).font(.caption2)
                        }
                        .padding([.leading, .trailing],  10)
                    }
                }
            )
            .navigationTitle("All Items List")
        }
    }
}

struct AllItemsCell_Previews: PreviewProvider {
    static var previews: some View {
        AllItemsCell(item: Item(id: "Id", name: "Preview Item",  itemId: "item id here", packed: true))
        //        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
