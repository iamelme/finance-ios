//
//  JournalVM.swift
//  Finance
//
//  Created by Elme delos Santos on 2/17/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class JournalViewModel: ObservableObject {
    @Published var currentUser: FirebaseAuth.User?
    @Published var db = Firestore.firestore()
    
    
    @Published var journals: [Journal] = []
    
    init() {
        self.currentUser = Auth.auth().currentUser
        
        self.journals = []
        

    }
    
    func addJournal(name: String, date: Date, accountId: String, note: String?) async throws {
        do {
            if(currentUser?.uid != nil)
            {
                let newJournalRef = db
                    .collection("users")
                    .document(currentUser!.uid)
                    .collection("journal").document()
                
                try await newJournalRef.getDocument()
                
                let journal = Journal(
                    id: newJournalRef.documentID,
                    date: date,
                    name: name,
                    note: note,
                    updatedAt: Date(),
                    userId: currentUser!.uid,
                    accountId: accountId
                )
                
                print("adding journal ==> \(journal)")
                
                try  newJournalRef.setData(from: journal)
                
            }
        } catch  {
            
        }
    }
    
    func updateJournal(journalId: String, name: String, date: Date, accountId: String, note: String?) async throws {
        do {
            if(currentUser?.uid != nil)
            {
               let journalRef = db
                    .collection("users")
                    .document(currentUser!.uid)
                    .collection("journal")
                    .document(journalId)
                
                let journal = Journal(
                    id: journalRef.documentID,
                    date: date,
                    name: name,
                    note: accountId,
                    updatedAt: Date(),
                    userId: currentUser!.uid,
                    accountId: accountId
                )
                
                let encodeJournal =  try Firestore.Encoder().encode(journal)
                
                try await journalRef.updateData(encodeJournal)
            }
            
            
        } catch {
            print("Error  \(error.localizedDescription)")
        }
    }
//    
    func deleteJournal(journalId:String, accountId: String, _ index: Int)async throws {
        print("deleting account... \(accountId)")
        
       
//        offsets.map { self.accounts[$0] }.forEach{account in
//            guard let accountId = try? account.id else {return}
            
//        }
        
        do {
            try await db
                .collection("users")
                .document(currentUser!.uid)
                .collection("journal")
                .document(journalId)
                .delete()
            
            self.journals.remove(at: index)
        } catch  {
            print("Error on delete \(error.localizedDescription)")
        }
    }
    
//    func fetchAccounts() async throws  {
//        self.accounts.removeAll()
//        if(currentUser?.uid != nil)
//        {
//            let querySnapShot = try await db
//                .collection("users")
//                .document(currentUser!.uid)
//                .collection("account")
//                .getDocuments()
//            
//            print("fetching...")
//            
//            for doc in querySnapShot.documents {
//                print("data doc \(doc.data())")
//                self.accounts.append(try doc.data(as: Account.self))
//            }
//            
//            print("\(self.accounts)")
//            
//        }
//    }
    
    func fetchJournals() async throws {
        // remove first the journals then retrieve fresh items from firestore
        self.journals.removeAll()
        
        print("fetching journals...")
        
        do {
            if(currentUser?.uid != nil)
            {
                let querySnapShot = try await db
                    .collection("users")
                    .document(currentUser!.uid)
                    .collection("journal")
//                    .whereField("userId", isEqualTo: currentUser!.uid)
                    .getDocuments()
                
                for doc in querySnapShot.documents {
                    print("docs for each ==> \(doc.documentID)")
                    self.journals.append(try doc.data(as: Journal.self))
                }
            }
        } catch  {
            print("Error \(error.localizedDescription)")
        }
    }
    
}
