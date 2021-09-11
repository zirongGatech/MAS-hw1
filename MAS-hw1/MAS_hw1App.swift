//
//  MAS_hw1App.swift
//  MAS-hw1
//
//  Created by Zirong Yu on 9/10/21.
//

import SwiftUI
import Firebase

@main
struct MAS_hw1App: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            CameraView()
        }
    }
}
