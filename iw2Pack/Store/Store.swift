//
//  Store.swift
//  HelloRedux
//
//  Created by Mohammad Azam on 9/14/20.
//

import Foundation

typealias Dispatcher = (Action) -> Void
typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

protocol ReduxState { }

struct AppState: ReduxState {
    var packAuthState = PackState()
    var counterState = CounterState()
    var taskState = TaskState()
}

struct TaskState: ReduxState {
    var tasks: [Task] = [Task]()
}

struct CounterState: ReduxState {
    var counter = 0
}

struct PackState: ReduxState {
    var loggedIn = false
    var allItems: [ Item ] = []
    var allItemsDict: [String: Item] = [ : ]
    var allEvents: [ Event ] = []
    var eventItems: [ Item ] = []
}

protocol Action { }

struct PackSetItemSelected: Action {
    let itemId: String
    let selected: Bool
}

struct PackSetPackedState: Action {
    let eventItem: EventItem
    var packedBool: Bool?
}

struct PackAllEvents_Get: Action { }
struct PackAllEvents_Store: Action {
    let allEvents: [Event]
}

struct PackEventItems_Get: Action {
    let eventId: String
}
struct PackEventItems_Store: Action {
    let eventItems: [ Item ]
}

struct PackAllItems_Get: Action { }
struct PackAllItems_Store: Action {
    let allItems: [Item]
}

struct PackAllItemsDict_Get: Action { }
struct PackAllItemsDict_Store: Action {
    let allItems: [String: Item]
}

struct PackAttemptLogin: Action {
    var email: String
    var password: String
}

struct PackSetAuthStatus: Action {
    let authStatus: Bool
}

struct IncrementAction: Action { }
struct DecrementAction: Action { }
struct IncrementActionAsync: Action { }

struct AddTaskAction: Action {
    let task: Task
}

struct AddAction: Action {
    let value: Int
}

class Store<StoreState: ReduxState>: ObservableObject {
    
    var reducer: Reducer<StoreState>
    @Published var state: StoreState
    var middlewares: [Middleware<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState, middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        // Run all middlewares
        middlewares.forEach {middleware in
            middleware(state, action, dispatch)
        }
    }
    
    
    
}
