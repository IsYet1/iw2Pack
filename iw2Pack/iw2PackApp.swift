//
//  iw2PackApp.swift
//  iw2Pack
//
//  Created by Don McKenzie on 15-Jan-22.
//

import SwiftUI
import Firebase

@main
struct iw2PackApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        let store = Store(reducer: reducer)
        
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
        
