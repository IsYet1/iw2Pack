//
//  EditItemDetails.swift
//  iw2Pack
//
//  Created by Don McKenzie on 25-Feb-22.
//

import SwiftUI

struct AddGlobalItem: View {
    @EnvironmentObject var store: Store<AppState>
    var packStateManager = PackStateManager()
    
    @State private var formItemName: String = ""
    @State private var formItemCategory: String = ""
    @State private var formItemLocation: String = ""
    
    init() {
        formItemName = ""
        formItemCategory = "active"
        formItemLocation = "closet"
    }
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        let packCategories = packState.categories
        let packLocations = packState.locations
        
        VStack {
            HStack {
                Text("Add New Global Item").font(.title)
                Spacer()
            }
            Spacer()
            HStack {
                TextField("Name", text: $formItemName)
                    .border(Color.gray)
                    .padding(5)
            }
            // TODO: Fix this code. Messy.
            HStack {
                Text("Category").frame(width: 100)
                Picker("", selection: $formItemCategory) {
                    ForEach(packCategories, id:\.self) {value in
                        Text(value)
                    }
                }
                Spacer()
            }
            HStack {
                Text("Location").frame(width: 100)
                Picker("", selection: $formItemLocation) {
                    ForEach(packLocations, id:\.self) {value in
                        Text(value)
                    }
                }
                Spacer()
            }
            Spacer()
            Button("Save") {
                let itemToAdd = ItemToAdd(name: formItemName, category: formItemCategory, location: formItemLocation)
                packState.addGlobalItem(store, itemToAdd)
            }
            .buttonStyle(.bordered)
            
        }
        .padding()
    }
}

struct AddGlobalItem_Previews: PreviewProvider {
    static var previews: some View {
        AddGlobalItem()
    }
}
