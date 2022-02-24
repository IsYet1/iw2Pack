//
//  LoginView.swift
//  FungiFinder
//
//  Created by Mohammad Azam on 11/3/20.
//

import SwiftUI

struct LoginView: View {
    
    @State var isPresented: Bool = false
    @State var isActive: Bool = false
    
    @StateObject private var loginVM = LoginViewModel()
    
   @EnvironmentObject var store: Store<AppState>
   struct StateActions {
        // props
        let authStatus: Bool
        // dispatch
        let attemptLogin: (String, String) -> Void
   }
    private func map(state: PackState) -> StateActions {
        return StateActions(authStatus: state.loggedIn,
             attemptLogin: { store.dispatch(action: PackAttemptLogin(email: $0, password: $1))}
        )
    }
    
    var body: some View {
        let props = map(state: store.state.packAuthState)
        VStack {
//            Image("mushroom")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .clipShape(Circle())
//                .padding(.bottom, 20)
//
            
            Spacer()
            TextField("Username", text: $loginVM.email)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $loginVM.password)
               
            Button("Login \(String(props.authStatus))") {
                props.attemptLogin(loginVM.email, loginVM.password)
                isActive = true
//                loginVM.login {
//                    isActive = true
//                    print("Login succeeded back to LoginView")
//                }
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 10)
            
//            Button("Create account") {
//                isPresented = true
//            }
//            .buttonStyle((.automatic))
//           
            Spacer()
           
            NavigationLink(
                destination: AllItemsView(),
//                destination: EventListView(),
                isActive: $isActive,
//                isActive: $store.state.packAuthState.loggedIn, // $isActive,
                label: {
                    EmptyView()
                }
            )
            
        }
        .padding()
        .defaultBackgroundView()
        .sheet(isPresented: $isPresented, content: {
            RegisterView() 
        })
        .navigationTitle("Login")
        .embedInNavigationView()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
