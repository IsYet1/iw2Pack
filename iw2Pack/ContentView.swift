//
//  ContentView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 15-Jan-22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store<AppState>
    var packStateManager = PackStateManager()
    
    var body: some View {
        let packState = packStateManager.map(state: store.state.packAuthState)
        VStack {
            LoginView()
//            EventListView()
//            MainView()
        }
        .onAppear(perform: {
            if !packState.loggedIn {
                packState.attemptLogin(store, "don@isyet.com", "remot5control")
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
