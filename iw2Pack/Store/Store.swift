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
}

struct PackState: ReduxState {
    var loggedIn = false
    var allItems: [ Item ] = []
    var allItemsDict: [String: Item] = [ : ]
    var allEvents: [ Event ] = []
    var eventItems: [ Item ] = []
    var categories: [String] = [ ]
    var locations: [String] = []
}

protocol Action { }

struct PackAddGlobalItem: Action{
    let item: ItemToAdd
}
struct PackAddGlobalItem_Local: Action{
    let item: ItemToAdd
}

struct PackCategories_Get: Action {
}
struct PackCategories_Store: Action {
    let categories: [String]
}

struct PackLocations_Get: Action {
}
struct PackLocations_Store: Action {
    let locations: [String]
}

struct PackUpdateGlobalItem: Action {
    let item: ItemUpdate
}

struct PackUpdateGlobalItem_Local: Action {
    let item: ItemUpdate
}

struct PackSetItemSelected: Action {
    let itemId: String
    let selected: Bool
}

struct PackRemoveItemFromLocalEventList: Action {
    let eventItemId: String
}

struct PackAddEventItemToLocalEventList: Action {
    let eventItem: Item
}

struct PackDeleteItemsFromEvent: Action {
    let eventId: String
    // NOTE: Leaving this as an array to support multiple deletes in the future. Initial will be 1 at a time
    let itemIds: [String]
}

struct PackAddItemsToEvent: Action {
    let eventId: String
    let itemIds: [String]
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
