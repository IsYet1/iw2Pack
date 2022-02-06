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
        let setAuthStatus: (Bool) -> ()
        let attemptLogin: (String, String) -> Void
   }
    private func map(state: PackState) -> StateActions {
        return StateActions(authStatus: state.loggedIn,
            setAuthStatus: { authStatus in store.dispatch(action: PackSetAuthStatus(authStatus: authStatus))},
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
               
            Button("Login") {
                props.attemptLogin(loginVM.email, loginVM.password)
                loginVM.login {
                    isActive = true
                    print("Login succeeded back to LoginView")
//                    props.setAuthStatus(true)
                }
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
//                destination: ItemListView(),
                destination: EventListView(),
                isActive: $isActive,
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
