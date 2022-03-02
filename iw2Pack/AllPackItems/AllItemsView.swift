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
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        
        VStack {
            NavigationView {
                List {
                    GroupedView(byLocation: byLocation)
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
    let byLocation: Bool
    
    @EnvironmentObject var store: Store<AppState>
    var packStateManager = PackStateManager()
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        let groupedItems = !byLocation ? packState.allItemsByCategory : packState.allItemsByLocation
        
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
