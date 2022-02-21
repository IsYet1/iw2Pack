//
//  AddItemsToEventList.swift
//  iw2Pack
//
//  Created by Don McKenzie on 21-Feb-22.
//

import SwiftUI

struct AddItemsToEventList: View {
    var eventId: String
    var eventName: String
    var itemsForList: [ Item ]
    
    var body: some View {
        VStack {
            Text("Add items to \(eventName)").font(.largeTitle)
            Divider()
            Spacer()
        }
    }
}

struct AddItemsToEventList_Previews: PreviewProvider {
    static var previews: some View {
        AddItemsToEventList(
            eventId: "amz",
            eventName: "Amazon",
            itemsForList: [
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1")
            ]
        )
    }
}
