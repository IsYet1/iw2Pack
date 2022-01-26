//
//  ContentView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 15-Jan-22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ReduxSample()
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
