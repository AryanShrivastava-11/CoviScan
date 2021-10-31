//
//  MenuView.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 30/10/21.
//

import SwiftUI
import Firebase

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                MenuRow(title: "Sign out", icon: "person.crop.circle")
                
                VStack {
                    Text("Designed and Developed")
                        .font(.caption2)
                    Text("by")
                        .font(.caption2)
                    Text("Aryan Shrivastava")
                        .font(.caption2)
                }
                
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    @EnvironmentObject var user: UserStore
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                UserDefaults.standard.set(false, forKey: "isLogged")
                user.isLogged = false
                
                let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
               } catch let signOutError as NSError {
                 print("Error signing out: %@", signOutError)
               }
            } label: {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .light))
                    .imageScale(.large)
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
                
                Text(title)
                    .foregroundColor(Color.primary)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(width: 120, alignment: .leading)
                //frame is set for text becuz if the length increases, it will set accordingly
            }

        }
    }
}
