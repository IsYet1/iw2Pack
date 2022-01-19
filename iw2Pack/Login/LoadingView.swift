//
//  LoadingView.swift
//  FungiFinder
//
//  Created by Mohammad Azam on 11/5/20.
//

import SwiftUI

struct LoadingView: View {
    
    let loadingState: LoadingState

    var body: some View {
        switch loadingState {
        case .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: 100)
                .scaleEffect(1.5, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .padding()
        case .idle, .success, .failure:
            EmptyView()
        }
//        Text("Loading View")
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingState: .loading)
    }
}
