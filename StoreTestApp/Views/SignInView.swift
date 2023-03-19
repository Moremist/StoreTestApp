//
//  SignInView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct SignInView: View {
    @State var firstNameText: String = ""
    @State var lastNameText: String = ""
    @State var emailText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text(Strings.signIn)
                    .font(.montserratBold36)
                    .padding(.top, 128)
                
                Spacer()
                
                VStack(spacing: 35) {
                    TextFieldInCapsuleView(text: $firstNameText, placeHolder: Strings.firstName)
                    TextFieldInCapsuleView(text: $lastNameText, placeHolder: Strings.lastName)
                    TextFieldInCapsuleView(text: $emailText, placeHolder: Strings.email)
                }
                
                LogInButtonView(title: Strings.signIn, action: {
                    
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

struct SignInWithButtonView: View {
    var iconImageName: String
    var text: String
    
    var body: some View {
        Button {
            
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
        SignInView()
    }
}
