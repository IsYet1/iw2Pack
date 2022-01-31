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
        let counter: Int
        let onIncrement: () -> Void
        let onDecrement: () -> Void
        let onAdd: (Int) -> Void
    }
  
    @StateObject private var eventListVM = EventListViewModel()
    @StateObject private var allItemsListVM = AllItemsListViewModel()
    
    var body: some View {
        VStack {
            Text("\(store.state.counterState.counter)")
            if (eventListVM.events.count > 0) {
                Text("There are \(eventListVM.events.count) events")
                
                List (eventListVM.events, id: \.eventId) {event in
                    EventCell(event: event)
                }
            } else if eventListVM.loadingState == .success && eventListVM.events.count == 0 {
                Text("There are NO items YET")
            }

        }
        .onAppear(perform: {
            print("Getting all items")
            eventListVM.getAllEvents()
            allItemsListVM.getAllItems()
        })
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
