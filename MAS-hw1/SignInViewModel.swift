//
//  SignInViewModel.swift
//  MAS-hw1
//
//  Created by Zirong Yu on 9/11/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class SignInViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var errSignInMsg = ""
    @Published var errSignOnMsg = ""
    @Published var signedIn = false
    
    var isSignIn: Bool {
        return auth.currentUser == nil
    }
    
    func signIn(email: String, password: String) {
        self.errSignInMsg = ""
        self.errSignOnMsg = ""
        auth.signIn(withEmail: email, password: password) { [weak self] res, err in
            guard res != nil, err == nil else {
                self?.errSignInMsg = err?.localizedDescription ?? ""
                print("Error in Sign In")
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOn(email: String, password: String) {
        self.errSignInMsg = ""
        self.errSignOnMsg = ""
        auth.createUser(withEmail: email, password: password) { [weak self] res, err in
            guard res != nil, err == nil else {
                self?.errSignOnMsg = err?.localizedDescription ?? ""
                print("Error in Sign On")
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
    func signOut(){
        try? auth.signOut()
        signedIn = false
    }
    
}
