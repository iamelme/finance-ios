//
//  AccountListView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/31/24.
//

import SwiftUI

struct AccountListView: View {
    
    
    @State private var isPresented = false
    
    @StateObject var accountModel = AccountModel()

    
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    Section(header: Text("Revenue")) {
                        ForEach(accountModel.accounts, id: \.self.id) {account in
                            if(account.type == AccountType.revenue) {
                                NavigationLink(destination: AccountFormView(account: account)){
                                    HStack {
                                        Text(account.name)
                                    }
                                }
                                
                            }
                        }
                        .onDelete{indexSet in
                            indexSet.forEach{index in
                                let accountId = accountModel.accounts[index].id
                                Task {
                                    try await accountModel.deleteAccount(accountId: accountId, index)
                                }
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Expense")) {
                        ForEach(accountModel.accounts, id: \.self.id) {account in
                            if(account.type == AccountType.expense) {
                                NavigationLink(destination: AccountFormView(account: account)){
                                    HStack {
                                       
                                        Text(account.name)
                                       
                                    }
                                }
                            }
                        }.onDelete{indexSet in
                            indexSet.forEach{index in
                                let accountId = accountModel.accounts[index].id
                                Task {
                                    try await accountModel.deleteAccount(accountId: accountId, index)
                                }
                            }
                            
                        }
                    }
                    
                }
                .onAppear{
                    print("on appear ")
                    Task {
                        try? await accountModel.fetchAccounts()
                    }
                }
                .sheet(isPresented: $isPresented, onDismiss: {
                    Task {
                        try? await accountModel.fetchAccounts()
                    }
                }) {
                    AccountFormView(account: Account(id: "", name: "", type: .expense, userId: ""))
                        .presentationDetents([.medium])
                }
                
                .refreshable {
                            try? await accountModel.fetchAccounts()
                         }

                
                
                
                MenuView()
               
            }
            .navigationBarTitle(Text("Account List"), displayMode: .inline)
//            .navigationBarBackButtonHidden(true)
    
            .toolbar {
                Button {
                    isPresented = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
//                            .frame(width: 12, height: 12, alignment: .center)
                        Text("Add")
                    }
                }
            }

        }
    }
}

#Preview {
    AccountListView()
}
