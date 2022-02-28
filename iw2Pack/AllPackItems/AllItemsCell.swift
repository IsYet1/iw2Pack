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
    @State private var byLocation: Bool
    
    init(item: Item, groupBy: GroupItemsBy) {
        curItem = item
        itemName = item.name ?? "Name Not Set"
        itemCategory = item.category ?? "Category Not Set"
        itemLocation = item.location ?? "Location Not Set"
        byLocation = groupBy == .location
    }
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: EditItemDetails(packItem: curItem, byLocation: byLocation),
                label: {
                    VStack {
                        HStack {
                            Text(itemName).font(.callout)
                            Spacer()
                        }
                        .padding([.leading, .trailing],  10)
                        HStack {
                            
                            Text(byLocation ? itemCategory : itemLocation).font(.caption2)
                            Spacer()
//                            Text(itemLocation).font(.caption2)
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
        AllItemsCell(item: Item(id: "Id", name: "Preview Item",  itemId: "item id here", packed: true), groupBy: GroupItemsBy.none)
        //        ItemCell(item: ItemViewModel(item: Item(id: "Id", name: "Preview Item")))
    }
}
