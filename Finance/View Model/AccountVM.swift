//
//  AccountModel.swift
//  Finance
//
//  Created by Elme delos Santos on 1/31/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class AccountModel: ObservableObject {
    @Published var currentUser: FirebaseAuth.User?
    @Published var db = Firestore.firestore()
    
    @Published var accounts : [Account] = []
    
    
    init() {
        self.currentUser = Auth.auth().currentUser
        
        self.accounts = []
        
        
        Task {
            try await fetchAccounts()
        }
    }
    
    
    func addAccount( name: String, type: AccountType) async throws {
        do {
            if(currentUser?.uid != nil)
            {
                
                
                let newAccountRef = db
                    .collection("users").document(currentUser!.uid)
                    .collection("account").document()
                
                try await newAccountRef.getDocument()
                
                print("newAccountRef \(newAccountRef.documentID)")
                
                let account = Account(
                    id: newAccountRef.documentID,
                    name: name,
                    type: type,
                    userId:  currentUser!.uid
                )
                
                
                print("add account \(account)")
                
//                let encodeAccount =  try Firestore.Encoder().encode(account)
//                
//                print("encodeAccount \(encodeAccount)")
                
                try  newAccountRef.setData(from: account)
//                print("before account list \(self.accounts)")
//
//                self.accounts.append(account)
//                
//                
//                
//                print("account list \(self.accounts)")
            }

        } catch  {
            print("Error \(error.localizedDescription)")
        }
    }
    
    
    func updateAccount(accountId: String, name: String, type: AccountType) async throws {
        do {
            if(currentUser?.uid != nil)
            {
               let accountRef = db
                    .collection("users")
                    .document(currentUser!.uid)
                    .collection("account")
                    .document(accountId)
                
                let account = Account(
                    id: accountRef.documentID,
                    name: name,
                    type: type,
                    userId:  currentUser!.uid
                )
                
                let encodeAccount =  try Firestore.Encoder().encode(account)
                
                try await accountRef.updateData(encodeAccount)
            }
            
            
        } catch {
            print("Error  \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(accountId: String, _ index: Int)async throws {
        print("deleting account... \(accountId)")
        
       
//        offsets.map { self.accounts[$0] }.forEach{account in
//            guard let accountId = try? account.id else {return}
            
//        }
        
        do {
            try await db
                .collection("users")
                .document(currentUser!.uid)
                .collection("account")
                .document(accountId).delete()
            
            self.accounts.remove(at: index)
        } catch  {
            print("Error on delete \(error.localizedDescription)")
        }
    }
    
    func fetchAccounts() async throws  {
        self.accounts.removeAll()
        if(currentUser?.uid != nil)
        {
            let querySnapShot = try await db
                .collection("users")
                .document(currentUser!.uid)
                .collection("account")
//                .whereField("userId", isEqualTo: currentUser!.uid)
                .getDocuments()
            
            print("fetching...")
            
            for doc in querySnapShot.documents {
                print("data doc \(doc.data())")
                self.accounts.append(try doc.data(as: Account.self))
            }
            
            
            print("\(self.accounts)")
            
        }
    }
    
}
