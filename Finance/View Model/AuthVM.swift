//
//  AuthView.swift
//  Finance
//
//  Created by Elme delos Santos on 1/28/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: String?
    
    @Published var isAuthenticating = false
    
    @Published var db = Firestore.firestore()
    
    
    enum ValidationError: Error {
        case emptyName
        case passTooShort(passLength: Int)
        case userIsNotActive 
    }
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.isAuthenticating = true
        
        Task {
            try await fetchUser()
        }
    }
    
    
    func signIn(email: String, password: String) async throws {
        print("Your email is \(email) and your password is \(password)")
        self.errorMessage = ""
        do {
            let res = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = res.user
            
            try await fetchUser()
        } catch  {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signUp(email: String, firstName: String, lastName: String, password: String) async throws {
        self.errorMessage = ""
        do {
            let res = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = res.user
            let user = User(id: res.user.uid, email: email, firstName: firstName, lastName: lastName, isActive: false)
            
            let encodeUser = try Firestore.Encoder().encode(user)
            try await db.collection("users").document(user.id).setData(encodeUser)
            try await fetchUser()
            print(res)
        } catch  {
            print("error \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch  {
            print("Failed to sign out")
        }
    }
    
    func fetchUser() async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            guard let snapshot = try? await db.collection("users").document(uid).getDocument() else {return}
            
            
            
            let user = try snapshot.data(as: User.self)
            print("fetching user... \(user)")
            self.currentUser = user

            // done
            self.isAuthenticating = false
            
        } catch  {
            self.errorMessage = error.localizedDescription
            print("Failed fetch")
        }
     
    }
}
