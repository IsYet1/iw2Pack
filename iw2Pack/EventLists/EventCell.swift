//
//  EventCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 24-Jan-22.
//

import SwiftUI

struct EventCell: View {
    let event: Event
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: ItemListView(eventId: event.id!, eventName: event.name!),
                label: {
                    Text(event.name!)
                }
            )
            .navigationTitle("Events List")
        }
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(event: Event(id: "Id", name: "Preview Item"))
        //        EventCell(event: EventViewModel(event: Event(id: "Id", name: "Preview Item")))
    }
}
