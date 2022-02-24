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
    var packStateManager = PackStateManager()
    
    var body: some View {
        let props = packStateManager.map(state: store.state.packAuthState)
        VStack {
           
            Spacer()
            TextField("Username", text: $loginVM.email)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $loginVM.password)
            
            Button("Login \(String(props.loggedIn))") {
                props.attemptLogin(store, loginVM.email, loginVM.password)
                isActive = true
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 10)
            
           Spacer()
            
            NavigationLink(
                destination: MainView(),
                isActive: $isActive,
                label: {
                    EmptyView()
                }
            )
            
        }
        .padding()
//        .defaultBackgroundView()
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
