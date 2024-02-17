//
//  SignUpView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                InputView(text: $email, title:"Email Address", placeholder: "Email address")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                InputView(text: $firstName, title:"First Name", placeholder: "First name")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                InputView(text: $lastName, title:"Last Name", placeholder: "Last name")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                InputView(text: $password, title:"Password", placeholder: "Password", isSecure: true)
                
                if authModel.errorMessage != nil {Text(authModel.errorMessage ?? "")}
                
                Button
                {
                    Task {
                        try await authModel.signUp(email: email, firstName: firstName, lastName: lastName, password: password)
                    }
                }label: {
                    HStack {
                        Text("Sign Up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
                Spacer()
                
                NavigationLink {
                    LoginView()
                } label: {
                    HStack(spacing: 3) {
                        Text("Sign In")
                    }
                }
            }
            .navigationTitle("Sign Up")
            .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            .padding()
        }
    }
}

#Preview {
    SignUpView()
}
