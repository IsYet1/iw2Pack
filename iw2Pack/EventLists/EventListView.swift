//
//  EventListView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 24-Jan-22.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var store: Store<AppState>
    struct Props {
        var allEvents: [ Event ]
    }
    private func map(state: PackState) -> Props {
        return Props(
            allEvents: state.allEvents
        )
    }
  
    var body: some View {
        let props = map(state: store.state.packAuthState)
        VStack {
            if (props.allEvents.count > 0) {
                Text("There are \(String(props.allEvents.count)) events")
                
                List (props.allEvents, id: \.id) {event in
                    EventCell(event: event)
                }
            } else if props.allEvents.count == 0 {
                Text("There are NO items YET")
            }

        }
        .onAppear(perform: {
            print("Getting all items")
        })
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
