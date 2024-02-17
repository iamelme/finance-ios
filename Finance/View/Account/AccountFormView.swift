//
//  AccountFormView.swift
//  Finance
//
//  Created by Elme delos Santos on 2/3/24.
//

import SwiftUI

struct AccountFormView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var accountModel = AccountModel()
    
    @State private var id = ""
    @State private var name = ""
    @State private var type: AccountType = .expense
    
    var account: Account?
    
    

    init(account: Account) {
        
        print("account form view ==> \(account)")
        self._id = State(initialValue: account.id)
        self._name = State(initialValue: account.name)
        self._type = State(initialValue: account.type)
        
        
//        self._account = State(initialValue: Account(id: account.id, name: account.name, type: .expense, userId: account.userId))
           

        }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Todo make sure name value is unique

                
                InputView(text: $name, title:"Name", placeholder: "Enter account name")
                
                          Picker("Type", selection: $type) {
                              ForEach(AccountType.allCases, id: \.self) {type in
                                  Text(type.rawValue)
                              }
                          }.labelsHidden()
                         
               
                
            }
                    .navigationTitle("\(id != "" ? "Edit" : "New") Account")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        Task {
                            
                            if(id != "") {
                                print("updating/patching")
                                try await accountModel.updateAccount(accountId: id, name: name, type: type )
                            } else {
                                try await accountModel.addAccount(name: name, type: type )
                            }
                            
                            //try? await accountModel.fetchAccounts()
                            
                            dismiss()
                        }
                    }
                }
                }
            
        }
        
    }
}

//#Preview {
//    AccountFormView()
//}
