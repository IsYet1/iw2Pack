//
//  EditItemDetails.swift
//  iw2Pack
//
//  Created by Don McKenzie on 25-Feb-22.
//

import SwiftUI

struct EditItemDetails: View {
//    @EnvironmentObject var store: Store<AppState>
//    var packStateManager = PackStateManager()
    @State private var formItemName: String = ""
    var curItem: Item
  
    init(packItem: Item) {
        formItemName = packItem.name!
        curItem = packItem
    }

    var body: some View {
        VStack {
            Text(curItem.name!).font(.title)
            TextField("Name", text: $formItemName)
            Spacer()
        }
    }
}

struct EditItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        EditItemDetails(packItem: Item(id: "Preview Item", name: "Preview Item", category: "Cat" ))
    }
}
