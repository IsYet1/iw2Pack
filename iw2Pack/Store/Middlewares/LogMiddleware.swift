//
//  LogMiddleware.swift
//  iw2Pack
//
//  Created by Don McKenzie on 05-Feb-22.
//

import Foundation

func logMiddleware() -> Middleware<AppState> {
    return {state, action, dispatch in
        print("Log Middleware STATE :: \(state)")
        print("Log Middleware ACTION :: \(action)")
    }
}
