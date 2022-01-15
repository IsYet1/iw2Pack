//
//  ContentView.swift
//  iw2Pack
//
//  Created by Don McKenzie on 15-Jan-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, There world! From the iw2 Pack App")
            TaskContentView()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
