//
//  SignInView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI


struct SignInView: View {
    @ObservedObject var viewModel = SignInViewModel()
    
    var isPresented: Bool
    @State var firstNameText: String = ""
    @State var lastNameText: String = ""
    @State var emailText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("mainBGColor")
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { reader in
                    VStack {
                        Text(Strings.signIn)
                            .font(.montserratBold36)
                            .padding(.top, reader.size.height / 8)
                        
                        Spacer()
                        
                        VStack(spacing: 35) {
                            TextFieldInCapsuleView(text: $firstNameText, placeHolder: Strings.firstName, type: .alphabet)
                            TextFieldInCapsuleView(text: $lastNameText, placeHolder: Strings.lastName, type: .alphabet)
                            TextFieldInCapsuleView(text: $emailText, placeHolder: Strings.email, type: .emailAddress)
                        }
                        .padding(.top, reader.size.height / 10)
                        
                        CommonButton(title: Strings.signIn, action: {
                            viewModel.registerUser(firstName: firstNameText, lastName: lastNameText, email: emailText)
                        })
                        .padding(.top, 35)
                        
                        HStack {
                            Text(Strings.alreadyHaveAnAccount)
                                .font(.montserratRegular12)
                                .foregroundColor(.gray)
                            
                            NavigationLink {
                                LogInView()
                            } label: {
                                Text(Strings.logIn)
                                    .font(.montserratRegular12)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 8)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 38) {
                            SignInWithButtonView(iconImageName: "googleIcon", text: Strings.signInWithGoogle)
                            SignInWithButtonView(iconImageName: "appleIcon", text: Strings.signInWithApple)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .opacity(isPresented ? 1 : 0)
        .overlay {
            CommonAlertView(
                title: viewModel.alertTitle,
                description: viewModel.alertDescription,
                isPresented: $viewModel.alertPresented
            )
        }
    }
}

struct SignInWithButtonView: View {
    @AppStorage(UserDefaults.Keys.loggedInKey) private var loggedIn = false
    
    var iconImageName: String
    var text: String
    
    var body: some View {
        Button {
            loggedIn = true
        } label: {
            HStack {
                Image(iconImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text(text)
                    .font(.montserratRegular16)
                    .foregroundColor(.black)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isPresented: true)
    }
}
