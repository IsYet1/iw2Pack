//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Azam on 9/14/20.
//

import SwiftUI

struct ReduxSample: View {
    
    @EnvironmentObject var store: Store<AppState>
    
    struct Props {
        let counter: Int
        let onIncrement: () -> Void
        let onIncrementAsync: () -> Void
        let onDecrement: () -> Void
        let onAdd: (Int) -> Void
    }
    
    private func map(state: CounterState) -> Props {
        Props(counter: state.counter
          , onIncrement: {
            store.dispatch(action: IncrementAction())
        }, onIncrementAsync: {
            store.dispatch(action: IncrementActionAsync())
        }, onDecrement: {
            store.dispatch(action: DecrementAction())
        }, onAdd: {
            store.dispatch(action: AddAction(value: $0))
        })
    }
    
    var body: some View {
        
        let props = map(state: store.state.counterState)
        
        VStack {
            Text("\(props.counter)")
                .padding()
            Button("Increment") {
                props.onIncrement()
            }
            Button("Increment Async") {
                props.onIncrementAsync()
            }
            Button("Decrement") {
                props.onDecrement()
            }
            Button("Add") {
                props.onAdd(100)
            }
        }
    }
}

struct ReduxSample_Previews: PreviewProvider {
    static var previews: some View {
        
//        let store = Store(reducer: reducer)
        let store = Store(reducer: appReducer, state: AppState())
        return ReduxSample().environmentObject(store)
    }
}
