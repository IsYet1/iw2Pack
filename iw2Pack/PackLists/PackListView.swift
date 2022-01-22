//
//  PackListView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 21-Jan-22.
//

import SwiftUI

struct PackListView: View {
    @StateObject private var packListVM = PackListViewModel()
    
    var body: some View {
        VStack {
            Text("Hello from PackListView")
            if (packListVM.items.count > 0) {
                Text("There are \(packListVM.items.count) items")
                List (packListVM.items, id: \.itemId) {item in
                    ItemCell(item: item)
                }
            } else if packListVM.loadingState == .success && packListVM.items.count == 0 {
                Text("There are NO items YET")
            }
        }
        .onAppear(perform: {
            print("Getting all items")
            packListVM.getAllItems()
        })
    }
}

struct PackListView_Previews: PreviewProvider {
    static var previews: some View {
        PackListView()
    }
}
