//
//  ItemsView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 19-Jan-22.
//

import SwiftUI

struct ItemListView: View {
    @StateObject private var itemListVM = ItemListViewModel()
    
    var body: some View {
        VStack {
            Text("Hello from ItemListView")
            if (itemListVM.items.count > 0) {
                Text("There are \(itemListVM.items.count) items")
            } else if itemListVM.loadingState == .success && itemListVM.items.count == 0 {
                Text("There are NO items YET")
            }
        }
        .onAppear(perform: {
            print("Getting all items")
            itemListVM.getAllItems()
        })
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
