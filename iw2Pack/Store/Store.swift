//
//  Store.swift
//  HelloRedux
//
//  Created by Mohammad Azam on 9/14/20.
//

import Foundation

typealias Reducer = (_ state: AppState, _ action: Action) -> AppState

struct AppState {
    var counter: Int = 0
}

protocol Action { }

struct IncrementAction: Action { }
struct DecrementAction: Action { }

struct AddAction: Action {
    let value: Int
}

func reducer(_ state: AppState, _ action: Action) -> AppState {
    
    var state = state
    
    switch action {
        case _ as IncrementAction:
            state.counter += 1
        case _ as DecrementAction:
            state.counter -= 1
        case let action as AddAction:
            state.counter += action.value
        default:
            break
    }
    
    return state
}


class Store: ObservableObject {
    
    var reducer: Reducer
    @Published var state: AppState
    
    init(reducer: @escaping Reducer, state: AppState = AppState()) {
        self.reducer = reducer
        self.state = state
    }
    
    func dispatch(action: Action) {
        state = reducer(state, action)
    }
    
}
