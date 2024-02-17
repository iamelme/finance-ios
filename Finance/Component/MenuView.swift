//
//  MenuView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/31/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var authModel : AuthModel
    
    var body: some View {
        HStack {
            NavigationLink {
                HomeView()
            } label: {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                        .font(.system(size: 12))
                }.frame(maxWidth: .infinity)
            }
            if  ((authModel.currentUser != nil) && authModel.currentUser?.isActive == true) {
                NavigationLink {
                    AccountListView()
                } label: {
                    VStack {
                        Image(systemName: "banknote")
                        Text("Account")
                            .font(.system(size: 12))
                    }.frame(maxWidth: .infinity)
                }
                
                NavigationLink {
                    JournalListView()
                } label: {
                    VStack {
                        Image(systemName: "note.text")
                        Text("Journal")
                            .font(.system(size: 12))
                    }.frame(maxWidth: .infinity)
                }

            } else {
                Text("Account")
            }
            NavigationLink {
                ProfileView()
            } label: {
                VStack {
                    Image(systemName: "person.circle")
                    Text("Profile")
                        .font(.system(size: 12))
                }.frame(maxWidth: .infinity)
                
            }
        }
    }
}

#Preview {
    MenuView()
}
