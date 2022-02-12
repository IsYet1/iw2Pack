//
//  IncrementMiddleware.swift
//  iw2Pack
//
//  Created by Don McKenzie on 05-Feb-22.
//

import Foundation

func incrementMiddleware() -> Middleware<AppState> {
    return {state, action, dispatch in
        switch action {
            case _ as IncrementActionAsync:
                DispatchQueue.main.asyncAfter (deadline: .now() + 2.0) {
                    dispatch(IncrementAction())
            }
            default:
                break
        }
    }
}
