//
//  CoviScanApp.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 29/10/21.
//

import SwiftUI
import Firebase

@main
struct CoviScanApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(UserStore())
        }
    }
}
