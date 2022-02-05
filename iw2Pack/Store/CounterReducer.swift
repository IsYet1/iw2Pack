//
//  CounterReducer.swift
//  CombiningReducers
//
//  Created by Mohammad Azam on 9/15/20.
//

import Foundation

func counterReducer(_ state: CounterState, _ action: Action) -> CounterState {
    
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
   print("Counter State in Reducer \(state)")
   return state
}
