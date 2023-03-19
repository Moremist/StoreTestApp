//
//  LogInView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct LogInView: View {
    @AppStorage("loggedIn") private var loggedIn = false

    @State var firstNameText: String = ""
    @State var passwordText: String = ""

    var body: some View {
        GeometryReader { reader in
            VStack {
                Text(Strings.welcomeBack)
                    .font(.montserratBold36)
                    .padding(.top, reader.size.height / 8 - 30)
                
                VStack(spacing: 35) {
                    TextFieldInCapsuleView(text: $firstNameText, placeHolder: Strings.firstName)
                    TextFieldInCapsuleView(text: $passwordText, placeHolder: Strings.password, isProtected: true)
                }
                .padding(.top, 80)
                
                CommonButton(title: Strings.logIn, action: {
                    loggedIn = true
                })
                .padding(.top, 99)
                
                Spacer()
                
            }
        }
        .padding()
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
