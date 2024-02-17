//
//  FinanceApp.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import SwiftUI
import Firebase

@main
struct FinanceApp: App {
    @StateObject var authModel = AuthModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authModel)
        }
    }
}
