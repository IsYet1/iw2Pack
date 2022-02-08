//
//  ItemsView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemListView: View {
    var eventId: String
    var eventName: String
    @StateObject private var itemListVM = ItemListViewModel()
    
    @EnvironmentObject var store: Store<AppState> // = Store(reducer: appReducer, state: AppState())

    struct PackStateElements {
        let eventItems: [ Item ]
        let getItemsForEvent: (String) -> Void
    }
    private func packStateMap(state: PackState) -> PackStateElements {
        return PackStateElements(
            eventItems: state.eventItems,
            getItemsForEvent: { store.dispatch(action: PackEventItems_Get(eventId: $0))}
        )
    }
 
    
    var body: some View {
        let packStateStore = packStateMap(state: store.state.packAuthState)
        
        let itemsForList = packStateStore.eventItems
        let itemsCount = itemsForList.count
        VStack {
            if (itemsCount > 0) {
                Text("There are \(itemsCount) items for Event: \(eventName)")
                List (itemsForList, id: \.itemId) {item in
                    ItemCell(item: item)
                }
            } else if itemsCount == 0 {
                Text("There are NO items YET")
            }
        }
        .onAppear(perform: {
            print("Getting EVENT items")
            packStateStore.getItemsForEvent(eventId)
//            itemListVM.getAllItems(eventId: eventId)
        })
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(eventId: "amz", eventName: "Amazon")
    }
}
