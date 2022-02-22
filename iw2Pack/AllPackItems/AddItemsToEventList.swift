//
//  AddItemsToEventList.swift
//  iw2Pack
//
//  Created by Don McKenzie on 21-Feb-22.
//

import SwiftUI

struct AddItemsToEventList: View {
    var eventId: String
    var eventName: String
    var itemsForEvent: [ Item ]
    
    @EnvironmentObject var store: Store<AppState> // = Store(reducer: appReducer, state: AppState())
    struct Props {
        let allItemsDict: [String: Item]
    }
    private func map(state: PackState) -> Props {
        return Props(
            allItemsDict: state.allItemsDict
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
 
    private func getItemsNotInEvent(allItemsDict: [String : Item]) -> [ Item ] {
        let itemsInEventList = Set(itemsForEvent.map { $0.itemId })
        let filteredItems  = allItemsDict.filter { key, value in
            return !itemsInEventList.contains(key)
        }
        return Array(filteredItems.values)
    }
 
    var body: some View {
        let props = map(state: store.state.packAuthState)
        let filteredItems = getItemsNotInEvent(allItemsDict: props.allItemsDict)
        let itemsByCategory = sortedByCategory(items: filteredItems)
        VStack {
            Text("Add items to \(eventName)")
            Divider()
//            List (filteredItems, id: \.id) {item in
//                AllItemCell(item: item)
//            }
            List {
                ForEach(itemsByCategory, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {item in
                            AllItemCell(item: item)
//                            ItemCell(item: item, eventId: eventId)
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct AddItemsToEventList_Previews: PreviewProvider {
    static var previews: some View {
        AddItemsToEventList(
            eventId: "amz",
            eventName: "Amazon",
            itemsForEvent: [
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1"),
                Item(id: "item1", name: "name1")
            ]
        )
    }
}
