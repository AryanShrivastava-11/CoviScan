//
//  ContentView.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 29/10/21.
//

import SwiftUI

struct ScannerView: View {
    @Binding var showProfile: Bool
    @State private var image = UIImage()
    @State private var showSheet = false
    @ObservedObject var store = Store()
    @State var showCard: Bool = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    
    var body: some View {
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
            TitleView(showProfile: $showProfile, show: $showCard)
                .background(
                    VStack {
                        LinearGradient(colors: [Color("background2"),Color("background1")], startPoint: .top, endPoint: .bottom)
                            .frame(height: 150)
                        Spacer()
                    }
                        .background(Color("background1"))
             )
            
            VStack(spacing: 50) {
                ImageView(showSheet: $showSheet, image: $image, show: $showCard)
                
                VStack(spacing: 20){
                    Button {
                        showSheet = true
                    } label: {
                        Text("Change photo")
                            .font(.headline)
                            .frame(maxWidth: screen.width - 100)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .shadow(color: .primary.opacity(0.3), radius: 1, x: 0, y: 1)
                            .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 10)
                    }

                    
                    Button {
                        API().fetchResult(image: image) { resultData in
                            store.result = resultData
                        }
                        showCard.toggle()
                        
                        //                    Text("covid perc: \(store.result.covid_percentage)")
                        //                    Text("pneumonia perc: \(store.result.pneumonia_percentage)")
                        //                    Text("normal perc: \(store.result.normal_percentage)")
                        //                    Text("prediction: \(store.result.prediction)")

                        
                        
                    } label: {
                        Text("Upload")
                            .font(.headline)
                            .frame(maxWidth: screen.width - 100)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .shadow(color: .primary.opacity(0.3), radius: 1, x: 0, y: 1)
                            .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 10)
                    }
                    
                }
                
            }
            .offset(y: 40)
            
            //BottomCardView starts from here
            
            VStack(spacing: 20){
                Rectangle()
                    .frame(width: 40, height: 5)
                    .cornerRadius(3)
                    .opacity(0.3)
                
                Text("The ML Model has proccessed your image and here are the results:")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .lineSpacing(3)
                
                HStack(spacing: 20.0) {
                    
                    VStack(alignment: .center, spacing: 8.0) {
                        Text("Covid Percentage")
                            .fontWeight(.bold)
                        RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 55, height: 55, percent: store.result.covid_percentage*100, show: $showCard)
                        
                    }
                    .padding(20)
                    .background(Color("background3"))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                }
                
                HStack(spacing: 20.0) {
                    
                    VStack(alignment: .center, spacing: 8.0) {
                        Text("Pneumonia Percentage")
                            .fontWeight(.bold)
                        RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 55, height: 55, percent: store.result.pneumonia_percentage*100, show: $showCard)
                        
                    }
                    .padding(20)
                    .background(Color("background3"))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                }

                HStack(spacing: 20.0) {
                    
                    VStack(alignment: .center, spacing: 8.0) {
                        Text("Normal Percentage")
                            .fontWeight(.bold)
                        RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 55, height: 55, percent: store.result.normal_percentage*100, show: $showCard)
                        
                    }
                    .padding(20)
                    .background(Color("background3"))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                }
                
                HStack(spacing: 20.0) {
                    
                    Text("Final Prediction:")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .lineSpacing(3)
                    
                    VStack(alignment: .center, spacing: 8.0) {
                        Text("\(store.result.prediction)")
                            .fontWeight(.bold)
                    }
                    .padding(20)
                    .background(Color("background3"))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                }
                
                Spacer()
                
            }
            .padding(.top, 8)
            .padding(.horizontal,20)
            .frame(maxWidth: .infinity) //setting it to infinity takes the full width
            .background(BlurView(style: .systemThinMaterial))
            .cornerRadius(30)
            .shadow(radius: 20)
            .offset(x: 0, y: showCard ? 400 : 1000)
            .offset(y: bottomState.height)
//                .blur(radius: show ? 20 : 0)
//            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.5))
            .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        bottomState = value.translation
                        if showFull{
                            bottomState.height += -350
                        }
                        if bottomState.height < -350{
                            /*This block of code is responsible for restricted movement of bottomCard in vertical direction*/
                            bottomState.height = -350
                        }
                    })
                .onEnded({ value in
                    if (bottomState.height > 50){
                        showCard = false
                    }
                    if bottomState.height < -200{
                        bottomState.height = -350
                        showFull = true
                    }
                    else{
                        bottomState = .zero
                        showFull = false
                        
                    }
                })
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(showProfile: .constant(false))
            .environmentObject(UserStore())
    }
}

struct TitleView: View {
    @Binding var showProfile: Bool
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Scanner")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .shadow(color: .primary.opacity(0.4), radius: 20, x: 0, y: 10)
                    
                    Spacer()
                    

                    
                        Button(action: { showProfile.toggle() }) {
                            //person.crop.circle.fill
                            Image(systemName: "person.fill.checkmark")
                                .font(.system(size: 30, design: .rounded))
                                .foregroundColor(.primary)
                                .padding(.horizontal,5)
                                .shadow(color: .primary.opacity(0.3), radius: 1, x: 0, y: 1)
                                .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 10)
                        }
                     
                }
                .padding(.top, 30)
                .padding()
                .zIndex(1)
                
                Image("Background1")
                    .resizable()
                    .frame(maxWidth: screen.width - 30, alignment: .top)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.8)
                    .offset(y: show ? -100 : 0)
                    .animation(.spring())

            }
            Spacer()
        }
    }
}

let screen = UIScreen.main.bounds

struct ImageView: View {
    @Binding var showSheet: Bool
    @Binding var image: UIImage
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Image(uiImage: self.image)
                .resizable()
                .cornerRadius(50)
                .frame(width: 200 , height: 200)
                .background(Color.gray)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                .sheet(isPresented: $showSheet) {
                    // Pick an image from the photo library:
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    
                    //  If you wish to take a photo from camera instead:
                    // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }
                .shadow(color: .primary.opacity(0.3),radius: 13, y: 10)
                .offset(y: show ? -170 : 0)
                .animation(.spring())
        }
    }
}
