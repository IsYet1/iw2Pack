//
//  EventCell.swift
//  iw2Pack
//
//  Created by Don McKenzie on 24-Jan-22.
//

import SwiftUI

struct EventCell: View {
    let event: EventViewModel
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: ItemListView(eventId: event.eventId),
                label: {
                    Text(event.eventId)
                }
            )
        }
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(event: EventViewModel(event: Event(id: "Id", name: "Preview Item")))
    }
}
