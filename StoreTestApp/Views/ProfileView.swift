//
//  ProfileView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

enum ProfileActionStyle: Equatable {
    case navigate, none, logOut
    case info(String)
}

struct ProfileAction {
    var icon: Image
    var text: String
    var style: ProfileActionStyle
}

struct ProfileView: View {
    private var actions: [ProfileAction] = [
        ProfileAction(icon: Image("cardIcon"), text: Strings.tradeStore, style: .navigate),
        ProfileAction(icon: Image("cardIcon"), text: Strings.paymentMethod, style: .navigate),
        ProfileAction(icon: Image("cardIcon"), text: Strings.balance, style: .info("$1593")),
        ProfileAction(icon: Image("cardIcon"), text: Strings.tradeHistory, style: .navigate),
        ProfileAction(icon: Image("restoreIcon"), text: Strings.restorePurchases, style: .navigate),
        ProfileAction(icon: Image("helpIcon"), text: Strings.help, style: .none),
        ProfileAction(icon: Image("logOutIcon"), text: Strings.logOut, style: .logOut)
    ]
    var body: some View {
        VStack {
            Text(Strings.profile)
                .font(.montserratBold16)
            
            Image(systemName: "person.crop.circle.dashed")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
                .padding(.top, 20)
            
            Button(
                action: {
                    
                },
                label: {
                    Text(Strings.changePhoto)
                        .font(.montserratRegular12)
                        .foregroundColor(.black)
                }
            )
            .padding(.top, 8)
            
            Text("Satria Adhi Pradana")
                .padding(.top, 5)
                .font(.montserratBold16)
            
            CommonButton(title: Strings.uploadItem, image: Image("uploadIcon")) {
                
            }
            .padding(.horizontal, 42)
            .padding(.top, 38)
            
            ScrollView(showsIndicators: false) {
                ForEach(actions, id: \.text) { action in
                    ProfileActionButtonView(icon: action.icon, text: action.text, style: action.style)
                        .padding(.top, 25)
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 14)
            
            Spacer()
        }
    }
}

struct ProfileActionButtonView: View {
    @AppStorage("loggedIn") private var loggedIn = false
    
    var icon: Image
    var text: String
    var style: ProfileActionStyle
    
    var body: some View {
        Button(
            action: {
                if style == .logOut {
                    loggedIn = false
                }
            },
            label: {
                HStack {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text(text)
                        .font(.montserratRegular16)
                    Spacer()
                    
                    actionStyleView()
                }
                .foregroundColor(.black)
            }
        )
    }
    
    private func actionStyleView() -> AnyView {
        switch style {
        case .navigate:
            return Image(systemName: "chevron.right")
                .resizable()
                .scaledToFill()
                .frame(width: 10, height: 10)
                .eraseToAnyView()
        case .info(let text):
            return Text(text).eraseToAnyView()
        case .none, .logOut:
            return EmptyView().eraseToAnyView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
