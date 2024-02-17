//
//  ContentView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        VStack {
            if(authModel.isAuthenticating) {
                
                Text("Loading...")
                
            } else {
                if authModel.userSession != nil && authModel.currentUser != nil {
                    
                    HomeView()
                    
                } else {
                    
                    LoginView()
                }
            }

        }
    }
}

#Preview {
    ContentView()
}
