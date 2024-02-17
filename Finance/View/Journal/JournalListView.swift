//
//  JournalListView.swift
//  Finance
//
//  Created by Elme delos Santos on 2/17/24.
//

import SwiftUI

struct JournalListView: View {
    @State private var isPresented = false
    
    @StateObject var journalViewModel = JournalViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    ForEach(journalViewModel.journals , id: \.self.id) {journal in
               
                            NavigationLink(destination: JournalFormView(journal: journal)){
                                HStack {
                                    Text(journal.name)
                                }
                            }
                    
                    }.onDelete{indexSet in
                        indexSet.forEach{index in
                            let journal = journalViewModel.journals[index]
                            Task {
                                try await journalViewModel.deleteJournal(journalId: journal.id, accountId: journal.accountId, index)
                            }
                        }
                        
                    }
                }
                .onAppear{
                    print("on appear ")
                    Task {
                        try? await journalViewModel.fetchJournals()  
                    }
                }
                .sheet(isPresented: $isPresented, onDismiss: {
                    Task {
                        try? await journalViewModel.fetchJournals()                    }
                }) {
                    JournalFormView(journal:
                                        Journal(
                                            id: "",
                                            date: Date(), 
                                            name: "",
                                            note: "",
                                            updatedAt: Date(),
                                            userId: "",
                                            accountId: "")
                    )
                    .presentationDetents([.large])
                }
                
                .refreshable {
                            try? await journalViewModel.fetchJournals()
                         }

                
                
                
                MenuView()
            }
            .navigationBarTitle(Text("Journal List"), displayMode: .inline)
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
    JournalListView()
}
