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
   struct Props {
        // props
        let authStatus: Bool
        // dispatch
        let onLoginAttempt: (Bool) -> ()
   }
    private func map(state: PackAuthState) -> Props {
        return Props(authStatus: state.loggedIn, onLoginAttempt: { authStatus in
            store.dispatch(action: SetAuthState(authStatus: authStatus))
        })
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
                loginVM.login {
                    isActive = true
                    print("Login succeeded back to LoginView")
                    props.onLoginAttempt(true)
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
