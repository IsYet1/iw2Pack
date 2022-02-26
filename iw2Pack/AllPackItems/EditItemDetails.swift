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
    var curItem: Item
  
    init(packItem: Item) {
        formItemName = packItem.name!
        formItemCategory = packItem.category!
        curItem = packItem
    }
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        let packCategories = packState.categories
        
        VStack {
            Text(curItem.name!).font(.title)
            Spacer()
            TextField("Name", text: $formItemName)
                .padding(30)
            HStack {
                Picker("Category", selection: $formItemCategory) {
                    ForEach(packCategories, id:\.self) {category in
                        Text(category)
                    }
                }
            }
//            .frame(width: .infinity, height: 30, alignment: .leading)
            Spacer()
            Button("Save") {
//                    self.presentation.wrappedValue.dismiss()
                }
                .buttonStyle(.bordered)
 
        }
    }
}

struct EditItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        EditItemDetails(packItem: Item(id: "Preview Item", name: "Preview Item", category: "Cat" ))
    }
}
