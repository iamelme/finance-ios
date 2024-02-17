//
//  Account.swift
//  Finance
//
//  Created by Elme delos Santos on 1/31/24.
//

import Foundation

struct Account:Identifiable,Codable, Hashable {
    let id: String
    let name: String
    let type: AccountType
    let userId: String
}

enum AccountType: String, CaseIterable, Identifiable, Codable {
    var id: AccountType {self}
    case revenue = "Revenue"
    case expense = "Expense"
}

extension Account {
    
}

