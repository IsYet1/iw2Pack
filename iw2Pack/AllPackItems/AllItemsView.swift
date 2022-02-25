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
            let listGroup: [String: [Item]] = Dictionary(grouping: itemsSorted, by: { book in
                return book.category!
            })
            return listGroup.sorted(by: {$0.key < $1.key})
        }
        return orderList
    }
 
    var body: some View {
        let props = packStateManager.map(state: store.state.packAuthState)
        let allItems = Array(props.allItemsDict.values)
        let itemsByCategory = sortedByCategory(items: allItems)
        VStack {
            Divider()
            NavigationView {
                List {
                    ForEach(itemsByCategory, id:\.key) {sections in
                        Section(header: Text(sections.key)) {
                            ForEach(sections.value, id: \.id) {item in
                                AllItemsCell(item: item)
                            }
                        }
                    }
                }
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
