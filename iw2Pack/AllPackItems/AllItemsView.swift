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
    
    private func sortedByCategory(items: [Item]) -> [(key: String, value: [Item] ) ]  {
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name! < $1.name! })
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { packItem in
                if let sortFieldValue = packItem.category {
                    return sortFieldValue
                } else {
                    return "___ No Category Set"
                }
                //                return packItem.category!
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    private func sortedByLocation(items: [Item]) -> [(key: String, value: [Item] ) ]  {
        var orderList: [(key: String, value: [Item] ) ] {
            let itemsSorted = items.sorted(by: { $0.name! < $1.name! })
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { packItem in
                if let sortFieldValue = packItem.location {
                    return sortFieldValue
                } else {
                    return "___ No Location Set"
                }
                //                return packItem.category!
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        let allItems = Array(packState.allItemsDict.values)
        let itemsByCategory = sortedByCategory(items: allItems)
        let itemsByLocation = sortedByLocation(items: allItems)
        VStack {
            Divider()
            NavigationView {
                //                List {
                //                    ForEach(allItems.sorted(by: {$0.name! < $1.name!}), id: \.id) {item in
                //                        AllItemsCell(item: item)
                //                    }
                //                }
                
                List {
                    ForEach(itemsByCategory, id:\.key) {sections in
                        Section(header: Text(sections.key)) {
                            ForEach(sections.value, id: \.id) {item in
                                AllItemsCell(item: item)
                            }
                        }
                    }
                }
                .refreshable(action: {
                    print("Refreshing. *****")
                    packState.loadAllItems(store)
                })
            }
            Spacer()
        }
    }
}

struct AllItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AllItemsView( )
    }
}
