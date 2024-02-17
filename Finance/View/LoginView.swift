//
//  LoginView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                InputView(text: $email, title:"Email Address", placeholder: "Email address")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                InputView(text: $password, title:"Password", placeholder: "Password", isSecure: true)
                
                if authModel.errorMessage != nil {Text(authModel.errorMessage ?? "")}
                
                Button
                {
                    Task {
                        try await  authModel.signIn(email: email, password: password)
                    }
                }label: {
                    HStack {
                        Text("Sign In")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
                Spacer()
                
                
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack(spacing: 3) {
                        Text("Sign Up")
                    }
                }
            }
            .navigationTitle("Sign In")
            .navigationBarBackButtonHidden(true)
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
