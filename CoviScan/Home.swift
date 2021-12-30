//
//  Home.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 30/10/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct Home: View {
    @State var showProfile: Bool = false
    @State var showScans: Bool = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
            ScannerView(showProfile: $showProfile, showScans: $showScans)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .offset(y: showProfile ? -screen.height/3 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height/15) - 10 : 0), axis: (x: 10.0, y: 0.0, z: 0.0))
                //the angle of rotation here depends upon the translation of MenuView done by the user
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
                
            MenuView()
                .background(Color.black.opacity(0.001)) //try changing the opacity to understand
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
//                .onTapGesture {
//                    showProfile.toggle()
//                }
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            viewState = value.translation
                        })
                        .onEnded({ value in
                            if(viewState.height > 50){
                                showProfile = false
                            }
                            viewState = .zero
                        })
                )
        }
    }
}

@available(iOS 15.0, *)
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
