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
    @State private var showLocationField: Bool
    var curItem: Item
    
    init(packItem: Item, byLocation: Bool) {
        formItemName = packItem.name ?? "No Name"
        formItemCategory = packItem.category ?? "active"
        formItemLocation = packItem.location ?? "closet"
        curItem = packItem
        showLocationField = byLocation
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
            // TODO: Fix this code. Messy.
            HStack {
                Text(showLocationField ? "Location:" : "Category").frame(width: 100)
                Picker("", selection: showLocationField ? $formItemLocation : $formItemCategory) {
                    ForEach(showLocationField ? packLocations : packCategories, id:\.self) {value in
                        Text(value)
                    }
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
        EditItemDetails(packItem: Item(id: "Preview Item", name: "Preview Item", category: "Cat" ), byLocation: false)
    }
}
