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
    struct Props {
        let eventItems: [ Item ]
        let getItemsForEvent: (String) -> Void
    }
    private func map(state: PackState) -> Props {
        return Props(
            eventItems: state.eventItems,
            getItemsForEvent: { store.dispatch(action: PackEventItems_Get(eventId: $0))}
        )
    }
    
    private func createItem1s() -> [Item1] {
        return [
            Item1(id: "01", name: "Item 01", packed: true, itemId: "zUgqtWUphDqP46Jfx6eh" ),
            Item1(id: "02", name: "Item 02", packed: false, itemId: "uiXp5m4fZDfQOYuksZOc" )
        ]
    }
    
    var body: some View {
        let props = map(state: store.state.packAuthState)
        let itemsForList = props.eventItems
//        let itemsForList = createItem1s() // props.eventItems
        let itemsCount = itemsForList.count
        VStack {
            if (itemsCount > 0) {
                Text("There are \(itemsCount) items for Event: \(eventName)")
                List (itemsForList, id: \.id) {item in
                    ItemCell(item: item)
                }
            } else if itemListVM.loadingState == .success && itemsCount == 0 {
                Text("There are NO items YET")
            }
        }
        .onAppear(perform: {
            print("Getting EVENT items")
//            itemListVM.getAllItems(eventId: eventId)
            props.getItemsForEvent(eventId)
        })
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(eventId: "amz", eventName: "Amazon")
    }
}
