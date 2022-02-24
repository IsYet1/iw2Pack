//
//  MainView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 24-Feb-22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            EventListView()
                .tabItem() {
                    Image(systemName: "1.circle")
                    Text("Events")
                }
             AllItemsView()
                .tabItem() {
                    Image(systemName: "1.square")
                    Text("All Items")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
