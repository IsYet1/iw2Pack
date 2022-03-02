//
//  AddItemsToEventList.swift
//  iw2Pack
//
//  Created by Don McKenzie on 21-Feb-22.
//

import SwiftUI

struct AllItemsView: View {
    @EnvironmentObject var store: Store<AppState>
    var packStateManager = PackStateManager()
    @State private var byLocation: Bool = false
    @State private var globalItems: [Item] = []
    
    private func groupItems(items: [Item]) -> [(key: String, value: [Item] ) ]  {
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name ?? "___ no name" < $1.name ?? "___ no name" })
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { packItem in
                return byLocation
                ? packItem.location ?? "___ LOCATION not set"
                : packItem.category ?? "___ CATEGORY not set"
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
//        globalItems = Array(packState.allItemsDict.values)
        let allItems = Array(packState.allItemsDict.values)
        
        let groupedItems = groupItems(items: allItems)
        
        VStack {
            NavigationView {
                List {
                    GroupedView(groupedItems: groupedItems, byLocation: byLocation)
//                    NonGroupedView(allItems: allItems)
                }
                .refreshable(action: {
                    print("Refreshing. *****")
                    packState.loadAllItems(store)
                })
                .toolbar(content: {
                    ToolbarItem(placement: .bottomBar) {
                        Toggle("By Location", isOn: $byLocation).toggleStyle(.switch)
                    }
                })
            }
        }
    }
}

struct AllItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AllItemsView( )
    }
}

struct GroupedView: View {
    let groupedItems: [(key: String, value: [Item] ) ]
    let byLocation: Bool
    var body: some View {
        ForEach(groupedItems, id:\.key) {sections in
            Section(header: Text(sections.key)) {
                ForEach(sections.value, id: \.id) {item in
                    AllItemsCell(item: item, groupBy: byLocation ? GroupItemsBy.location : GroupItemsBy.category)
                }
            }
        }
    }
}

struct NonGroupedView: View {
    let allItems: [Item]
    var body: some View {
        ForEach(allItems.sorted(by: {$0.name! < $1.name!}), id: \.id) {item in
            AllItemsCell(item: item, groupBy: GroupItemsBy.none)
        }
    }
}
