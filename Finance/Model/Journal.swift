//
//  Journal.swift
//  Finance
//
//  Created by Elme delos Santos on 2/17/24.
//

import Foundation

struct Journal:Identifiable, Codable, Hashable {
    let id: String
    let date: Date
    let name: String
    let note: String?
    let updatedAt: Date?
    
    let userId: String
    let accountId: String
}
