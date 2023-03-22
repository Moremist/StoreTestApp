//
//  LogInView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct LogInView: View {
    @AppStorage(UserDefaults.Keys.loggedInKey) private var loggedIn = false
    
    @ObservedObject var viewModel = LogInViewModel()
    
    @State var emailText: String = ""
    @State var passwordText: String = ""

    var body: some View {
        GeometryReader { reader in
            VStack {
                Text(Strings.welcomeBack)
                    .font(.montserratBold36)
                    .padding(.top, reader.size.height / 8 - 30)
                
                VStack(spacing: 35) {
                    TextFieldInCapsuleView(text: $emailText, placeHolder: Strings.email, type: .emailAddress)
                    TextFieldInCapsuleView(text: $passwordText, placeHolder: Strings.password, isProtected: true, type: .alphabet)
                }
                .padding(.top, 80)
                
                CommonButton(title: Strings.logIn, action: {
                    viewModel.checkUser(email: emailText)
                })
                .padding(.top, 99)
                
                Spacer()
                
            }
            .overlay {
                CommonAlertView(
                    title: viewModel.alertTitle,
                    description: viewModel.alertDescription,
                    isPresented: $viewModel.alertPresented
                )
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
