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
    @Environment(\.presentationMode) var presentation
    
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
 
    private func getItemsNotInEvent(allItemsDict: [String : Item]) -> [ Item ] {
        let itemsInEventList = Set(itemsForEvent.map { $0.itemId })
        let filteredItems  = allItemsDict.filter { key, value in
            return !itemsInEventList.contains(key)
        }
        return Array(filteredItems.values)
    }
 
    var body: some View {
        let props = packStateManager.map(state: store.state.packAuthState)
        let filteredItems = getItemsNotInEvent(allItemsDict: props.allItemsDict)
        let itemsByCategory = sortedByCategory(items: filteredItems)
        VStack {
            Text("Add items to \(eventName)")
            Divider()
            List {
                ForEach(itemsByCategory, id:\.key) {sections in
                    Section(header: Text(sections.key)) {
                        ForEach(sections.value, id: \.id) {item in
                            AllItemCell(item: item)
                        }
                    }
                }
            }
            Divider()
            Button("Add These") {
                let itemsToAdd = filteredItems.filter() {$0.selected != nil && $0.selected! }
                print("*** Selected Items")
                print(itemsToAdd )
                self.presentation.wrappedValue.dismiss()
            }
            .buttonStyle(.bordered)
 
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
