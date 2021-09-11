//
//  ContentView.swift
//  MAS-hw1
//
//  Created by Zirong Yu on 9/10/21.
//

import SwiftUI

struct LogContentView: View {
    
    @EnvironmentObject var signinViewModel: SignInViewModel
    
    var body: some View {
        NavigationView {
            if signinViewModel.signedIn {
                GallaryView(username: String("aaaa"))
                    .environmentObject(signinViewModel)
                    .navigationBarHidden(true)
            }else {
                SignInView()
            }
        }
    }
}

struct SignInView: View {
    @State var emailAccount: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var signinViewModel: SignInViewModel
    
    var body: some View {
        
        VStack {
            Text("IMAGE HERE")
            
            VStack{
                TextField("Email Address", text: $emailAccount)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                
                Button(action: {
                    guard !emailAccount.isEmpty, !password.isEmpty else {
                        print("text field empty")
                        return
                    }
                    
                    signinViewModel.signIn(email: emailAccount, password: password)
                }, label: {
                    Text("Sign In")
                        .bold()
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(Color(.green))
                    
                })
                .cornerRadius(10)
                .padding([.top, .leading, .trailing])
                
                NavigationLink("Create an Account", destination: SignOnView())
                    .padding(2.0)
                
                if !signinViewModel.errSignInMsg.isEmpty {
                    Text(signinViewModel.errSignInMsg)
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Sign In")
        
        
    }
}


struct SignOnView: View {
    @State var emailAccount: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var signinViewModel: SignInViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack{
                    TextField("Email Address", text: $emailAccount)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    
                    Button(action: {
                        guard !emailAccount.isEmpty, !password.isEmpty else {
                            print("text field empty")
                            return
                        }
                        
                        signinViewModel.signOn(email: emailAccount, password: password)
                    }, label: {
                        Text("Create")
                            .bold()
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color(.green))
                        
                    })
                    .cornerRadius(10)
                    .padding()
                    
                    if !signinViewModel.errSignOnMsg.isEmpty {
                        Text(signinViewModel.errSignOnMsg)
                            .foregroundColor(.red)
                    }
                    
                }
                .padding()
                
                Spacer()
            }
            .padding()
            
            .navigationTitle("Create an Account:")
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let signinViewModel = SignInViewModel()
        LogContentView()
            .environmentObject(signinViewModel)
    }
}
