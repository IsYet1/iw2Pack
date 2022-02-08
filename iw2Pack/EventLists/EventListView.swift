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
        var loggedIn: Bool
    }
    private func map(state: PackState) -> Props {
        return Props(
            allEvents: state.allEvents,
            loggedIn: state.loggedIn
        )
    }
  
    var body: some View {
        let props = map(state: store.state.packAuthState)
        VStack {
            Text("\(store.state.counterState.counter)")
            Text("Logged in? \(String(props.loggedIn))")
            if (props.allEvents.count > 0) {
                Text("Events count: \(String(props.allEvents.count))")
                
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
