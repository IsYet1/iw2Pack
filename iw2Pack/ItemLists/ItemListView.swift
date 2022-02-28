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
    
    @State private var showAddItemsToEventSheet: Bool = false
    
    @EnvironmentObject var store: Store<AppState> // = Store(reducer: appReducer, state: AppState())
    var packStateManager = PackStateManager()
    
    @State private var byLocation: Bool = false
    @State private var filterUnpacked: Bool = false
    
    // TODO: Normalize this. It's returning a 2 dimensional array. Would prefer a dictionary.
    private func groupItems(items: [Item]) -> [(key: String, value: [Item] ) ]  {
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name ?? "___ no name" < $1.name ?? "___ no name" })
            let itemsFiltered = !filterUnpacked
            ? itemsSorted
            : itemsSorted.filter() {!($0.packed!) }
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsFiltered, by: { packItem in
                return byLocation
                ? packItem.location ?? "___ LOCATION not set"
                : packItem.category ?? "___ CATEGORY not set"
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    private func removeItemFromEvent( at indexSet: IndexSet, items: [Item] ){
        print("*** Removing an item")
        if let itemIndex: Int = indexSet.first {
            print(itemIndex)
            if let eventItemId = items[itemIndex].id {
                print(eventId)
                print(eventItemId)
                print(items[itemIndex].name!)
                store.dispatch(action: PackDeleteItemsFromEvent(eventId: eventId, itemIds: [eventItemId]))
            }
        }
    }
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        let itemsForList = packState.eventItems
        let itemsCount = itemsForList.count
        let groupedItems = groupItems(items: itemsForList)
        VStack {
            if (itemsCount > 0) {
                Text(eventName).font(.title)
                Text("\(itemsCount) items").font(.footnote)
                List {
                    ForEach(groupedItems, id:\.key) {sections in
                        Section(header: Text(sections.key)) {
                            ForEach(sections.value, id: \.id) {item in
                                ItemCell(item: item, eventId: eventId)
                            }
                            .onDelete {self.removeItemFromEvent(at: $0, items: sections.value )}
                        }
                    }
                }
                .refreshable(action: {
                    print("Refreshing. *****")
                    packState.loadEventItems(store, eventId)
                })
            } else if itemsCount == 0 {
                Text("There are NO items YET")
            }
        }
        .onAppear(perform: {
            print("Getting EVENT items")
            packState.getItemsForEvent(store, eventId)
        })
        .toolbar {
           ToolbarItem(placement: .primaryAction) {
               Button("Add Items") {self.showAddItemsToEventSheet = true }
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Toggle("Unpacked", isOn: $filterUnpacked).toggleStyle(.switch)
                    Toggle("By Location", isOn: $byLocation).toggleStyle(.switch)
                }
            }
           
        }
        .sheet(isPresented: $showAddItemsToEventSheet, content: {
            AddItemsToEventList(
                eventId: eventId, eventName: eventName, itemsForEvent: itemsForList
            )
        })
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(eventId: "amz", eventName: "Amazon")
    }
}
