//
//  LoginView.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 30/10/21.
//

import SwiftUI
import Firebase

@available(iOS 15.0, *)
struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong."
    @State var isLoading = false
    @State var isSuccessful = false
    @State var isLoginMode = false
    @EnvironmentObject var user: UserStore
    
    func login() {
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        
        
        if isLoginMode {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                self.isLoading = false
                if error != nil{
                    alertMessage = error?.localizedDescription ?? ""
                    self.showAlert = true
                }else{
                    self.isSuccessful = true
                    user.isLogged = true
                    UserDefaults.standard.set(true, forKey: "isLogged")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.email = ""
                        self.password = ""
                        self.isSuccessful = false
                        user.showLogin = false
                    }
                }
            }
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                self.isLoading = false
                if error != nil{
                    alertMessage = error?.localizedDescription ?? ""
                    self.showAlert = true
                }else{
                    self.isSuccessful = true
                    user.isLogged = true
                    UserDefaults.standard.set(true, forKey: "isLogged")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.email = ""
                        self.password = ""
                        self.isSuccessful = false
                        user.showLogin = false
                    }
                }
            }
        }
        
        
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    } 
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .top) {
                
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverView()
                
                VStack(spacing: 10) {
                    Picker(selection: $isLoginMode) {
                        Text("Create Account")
                            .tag(false)
                        Text("Login")
                            .tag(true)
                    } label: {
                        Text("Picker for CreateAccout & Login")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .offset(y: -5)
                    
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                        }
                    }
                    
                    Divider().padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                        }
                    }
                }
                .frame(height: 160)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: isFocused ? -200 : 0)
                .offset(y: 470)
                .animation(.easeInOut)
                
                HStack {
                    Text("Forgot password?")
                        .font(.subheadline)
                        .onTapGesture {
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                if let err = error{
                                    alertMessage = err.localizedDescription
                                    self.showAlert = true
                                }else{
                                    alertMessage = "Email sent succesfully"
                                    self.showAlert = true
                                }
                            }
                        }
                    
                    Spacer()
                    
                    Button(action: {
                        self.login()
                    }) {
                        Text(isLoginMode ? "Log in" : "Sign In").foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Alert"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
                
                
            }
//            .offset(y: isFocused ? -300 : 0)
            .animation(isFocused ? .easeInOut : nil)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            
            if isLoading {
                LoadingView()
            }
            
            if isSuccessful {
                SuccessView()
            }
            
            if user.isLogged{
                Home()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

@available(iOS 15.0, *)
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
//        .previewDevice("iPad Air 2")
    }
}

struct CoverView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("CoviScan")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: geometry.size.width/5, weight: .bold))
                    .foregroundColor(Color("background3"))
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            .offset(x: viewState.width/15, y: viewState.height/15)
            
            Text("Covid 19/Pneumonia Detection System Using Chest Radiographs")
                .font(.subheadline)
                .frame(width: 250)
                .offset(x: viewState.width/20, y: viewState.height/20)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 300).repeatForever(autoreverses: false))
//                    .animation(nil)
                    .onAppear { self.show = true }
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
                    .blendMode(.hardLight)
                    .animation(Animation.linear(duration: 300).repeatForever(autoreverses: false))
//                    .animation(nil)
            }
        )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3"))
                    .offset(x: viewState.width/25, y: viewState.height/25)
                , alignment: .bottom
        )
            .background(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isDragging ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
            .gesture(
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                    self.isDragging = true
                }
                .onEnded { value in
                    self.viewState = .zero
                    self.isDragging = false
                }
        )
    }
}
