//
//  TaskReducer.swift
//  CombiningReducers
//
//  Created by Mohammad Azam on 9/16/20.
//

import Foundation

func taskReducer(_ state: TaskState, _ action: Action) -> TaskState {
    
    var state = state
    
    switch action {
        case let action as AddTaskAction:
            state.tasks.append(action.task)
        default:
            break 
    }
    
    return state
}
