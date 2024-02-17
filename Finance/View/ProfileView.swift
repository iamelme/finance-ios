//
//  ProfileView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authModel: AuthModel
    // inactive user can only access their profile
    // they cannot create an account and journal
    
    var body: some View {
        NavigationStack {
            if let user = authModel.currentUser {
                Section {
                    ProfileHeaderView(firstName: user.firstName, lastName: user.lastName)
                }
                
                if(user.isActive) {
                    Section {
                        Text("You're an active user")
//                        NavigationLink {
//                            AccountListView()
//                        } label: {
//                            HStack(spacing: 3) {
//                                Text("Account")
//                            }
//                        }
                    }
                }
                
                Button
                {
                    authModel.signOut()
                }label: {
                    HStack {
                        Text("Logout")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
                Spacer()
                
                
                MenuView()
                
            } else {
                Button
                {
                    authModel.signOut()
                }label: {
                    HStack {
                        Text("Logout")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
                if ((authModel.currentUser?.isActive) != nil) {
                    Text("No user")
                    Button
                    {
                        authModel.signOut()
                    }label: {
                        HStack {
                            Text("Logout")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                }
            }
        }
        .navigationBarTitle(Text("Profile"), displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ProfileView()
}
