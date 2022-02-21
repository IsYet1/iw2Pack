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
    
    @EnvironmentObject var store: Store<AppState> // = Store(reducer: appReducer, state: AppState())
    @State private var showAddItemsToEventSheet: Bool = false
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
    
    private func sortedByCategory(items: [Item]) -> [(key: String, value: [Item] ) ]  {
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name! < $1.name! })
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { book in
                return book.category!
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    var body: some View {
        let props = map(state: store.state.packAuthState)
        let itemsForList = props.eventItems
        let itemsCount = itemsForList.count
        let itemsByCategory = sortedByCategory(items: itemsForList)
        VStack {
            if (itemsCount > 0) {
                Text("There are \(itemsCount) items for Event: \(eventName)")
                List {
                    ForEach(itemsByCategory, id:\.key) {sections in
                        Section(header: Text(sections.key)) {
                            ForEach(sections.value, id: \.id) {item in
                                ItemCell(item: item, eventId: eventId)
                            }
                        }
                    }
                }
//                List (itemsForList, id: \.id) {item in
//                    ItemCell(item: item, eventId: eventId)
//                }
            } else if itemsCount == 0 {
                Text("There are NO items YET")
            }
        }
        .onAppear(perform: {
            print("Getting EVENT items")
            props.getItemsForEvent(eventId)
        })
        .toolbar {
           ToolbarItem(placement: .primaryAction) {
               Button("Add Items") {self.showAddItemsToEventSheet = true }
            }
           
        }
        .sheet(isPresented: $showAddItemsToEventSheet, content: {AddItemsToEventList()})
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(eventId: "amz", eventName: "Amazon")
    }
}
