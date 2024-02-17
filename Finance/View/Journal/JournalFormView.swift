//
//  JournalFormView.swift
//  Finance
//
//  Created by Elme delos Santos on 2/17/24.
//

import SwiftUI

struct JournalFormView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var journalViewModel = JournalViewModel()
    @StateObject var accountViewModel = AccountModel()

    
    @State private var id = ""
    @State private var name = ""
    @State private var date = Date()
    @State private var note = ""
    
    @State private var accountId = ""
    
    
    var journal: Journal?
    
    init(journal: Journal) {
        
        self._id = State(initialValue: journal.id)
        self._name = State(initialValue: journal.name)
        self._date = State(initialValue: journal.date)
        self._note = State(initialValue: journal.note ?? "")
        
        self._accountId = State(initialValue: journal.accountId)
    }
    
    
    
    
    var body: some View {
        NavigationStack {
        
            VStack {
                InputView(text: $name, title:"Name", placeholder: "Enter account name")
                
                DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                
                Picker("Account", selection: $accountId) {
                    ForEach(accountViewModel.accounts, id: \.self.id) {account in
                        Text(account.name)
                    }
                }.labelsHidden()
                
                TextEditor( text: $note)
            }
            .navigationTitle("\(id != "" ? "Edit" : "New") Journal")
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
                                try await journalViewModel.updateJournal( journalId: id, name: name, date: date, accountId: accountId, note: note)
                            } else {
                                try await journalViewModel
                                    .addJournal(
                                        name: name,
                                        date: date,
                                        accountId: accountId,
                                        note: note
                                    )
                            }
                            
                            
                            dismiss()
                        }
                    }
                }
            }
        }
        
    }
}

//#Preview {
//    JournalFormView()
//}
