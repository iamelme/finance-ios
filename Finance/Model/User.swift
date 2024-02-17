//
//  User.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let isActive: Bool
    
}
