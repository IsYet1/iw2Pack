//
//  EditItemDetails.swift
//  iw2Pack
//
//  Created by Don McKenzie on 25-Feb-22.
//

import SwiftUI

struct EditItemDetails: View {
    @EnvironmentObject var store: Store<AppState>
    var packStateManager = PackStateManager()
    
    @State private var formItemName: String = ""
    @State private var formItemCategory: String = ""
    @State private var formItemLocation: String = ""
    var curItem: Item
    
    init(packItem: Item) {
       if let value = packItem.name {
            formItemName = value
        } else {
            formItemName = "No Name"
        }
 
        if let value = packItem.category {
            formItemCategory = value
        } else {
            formItemCategory = "closet"
        }
        if let value = packItem.location {
            formItemLocation = value
        } else {
            formItemLocation = "closet"
        }
        curItem = packItem
    }
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        let packCategories = packState.categories
        let packLocations = packState.locations
        
        VStack {
            Text(curItem.name!).font(.title)
            Spacer()
            HStack {
                TextField("Name", text: $formItemName)
                    .border(Color.gray)
                    .padding(5)
                Spacer()
            }
            HStack {
                Text("Category:").frame(width: 100)
                Picker("Category", selection: $formItemCategory) {
                    ForEach(packCategories, id:\.self) {category in
                        Text(category)
                    }
                }
                Spacer()
            }
            HStack {
                Text("Location:").frame(width: 100)
                Picker("Location", selection: $formItemLocation) {
                    ForEach(packLocations, id:\.self) {location in
                        Text(location)
                    }
                    .border(Color.blue)
                    .frame(width: 200)
                }
                Spacer()
            }
            
            Spacer()
            Button("Save") {
                let itemToUpdate = ItemUpdate(id: curItem.id!, name: formItemName, category: formItemCategory, location: formItemLocation)
                packState.updateGlobalItem(store, itemToUpdate)
            }
            .buttonStyle(.bordered)
            
        }
        .padding()
    }
}

struct EditItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        EditItemDetails(packItem: Item(id: "Preview Item", name: "Preview Item", category: "Cat" ))
    }
}
