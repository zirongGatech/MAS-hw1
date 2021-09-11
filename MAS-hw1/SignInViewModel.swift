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
    
    @Published var signedIn = false
    
    var isSignIn: Bool {
        return auth.currentUser == nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] res, err in
            guard res != nil, err == nil else {
                print("Error in Sign In")
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
    func signOn(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] res, err in
            guard res != nil, err == nil else {
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
