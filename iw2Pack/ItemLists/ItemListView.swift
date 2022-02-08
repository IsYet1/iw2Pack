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
        let counter: Int
        let onIncrement: () -> Void
        let onDecrement: () -> Void
        let onAdd: (Int) -> Void
    }
     private func map(state: CounterState) -> Props {
        Props(counter: state.counter, onIncrement: {
            self.store.dispatch(action: IncrementAction())
        }, onDecrement: {
            self.store.dispatch(action: DecrementAction())
        }, onAdd: {
            self.store.dispatch(action: AddAction(value: $0))
        })
    }
 
    
    var body: some View {
        let props = map(state: store.state.counterState)
        let itemsCount = itemListVM.items.count
        VStack {
            if (itemsCount > 0) {
                Text("There are \(itemsCount) items for Event: \(eventName)")
                List (itemListVM.items, id: \.itemId) {item in
                    ItemCell(item: item)
                }
            } else if itemListVM.loadingState == .success && itemsCount == 0 {
                Text("There are NO items YET")
            }
        }
        .onAppear(perform: {
            print("Getting EVENT items")
            itemListVM.getAllItems(eventId: eventId)
        })
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(eventId: "amz", eventName: "Amazon")
    }
}
