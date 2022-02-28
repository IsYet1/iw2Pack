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
    
    private enum groupBy {
        case category
        case location
        case none
    }
    
    private func sortedByCategory(items: [Item]) -> [(key: String, value: [Item] ) ]  {
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name! < $1.name! })
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { packItem in
                return packItem.category ?? "___ CATEGORY not set"
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    private func sortedByLocation(items: [Item]) -> [(key: String, value: [Item] ) ]  {
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name! < $1.name! })
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { packItem in
                return packItem.location ?? "___ LOCATION set"
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        let allItems = Array(packState.allItemsDict.values)
        let sortItemsBy = byLocation ? groupBy.location : groupBy.category
        
        let itemsByCategory = sortedByCategory(items: allItems)
        let itemsByLocation = sortedByLocation(items: allItems)
        
        VStack {
            NavigationView {
                List {
                    switch sortItemsBy {
                    case .category:
                        GroupedView(groupedItems: itemsByCategory)
                    case .location:
                        GroupedView(groupedItems: itemsByLocation)
                    case .none:
                        ForEach(allItems.sorted(by: {$0.name! < $1.name!}), id: \.id) {item in
                            AllItemsCell(item: item)
                        }
                    }
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
    var body: some View {
        ForEach(groupedItems, id:\.key) {sections in
            Section(header: Text(sections.key)) {
                ForEach(sections.value, id: \.id) {item in
                    AllItemsCell(item: item)
                }
            }
        }
    }
}
