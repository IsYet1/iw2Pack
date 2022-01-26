//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Azam on 9/14/20.
//

import SwiftUI

struct ReduxSample: View {
    
    @EnvironmentObject var store: Store
    
    struct Props {
        let counter: Int
        let onIncrement: () -> Void
        let onDecrement: () -> Void
        let onAdd: (Int) -> Void
    }
    
    private func map(state: AppState) -> Props {
        Props(counter: state.counter, onIncrement: {
            store.dispatch(action: IncrementAction())
        }, onDecrement: {
            store.dispatch(action: DecrementAction())
        }, onAdd: {
            store.dispatch(action: AddAction(value: $0))
        })
    }
    
    var body: some View {
        
        let props = map(state: store.state)
        
        VStack {
            Text("\(props.counter)")
                .padding()
            Button("Increment") {
                props.onIncrement()
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
        
        let store = Store(reducer: reducer)
        return ReduxSample().environmentObject(store)
    }
}
