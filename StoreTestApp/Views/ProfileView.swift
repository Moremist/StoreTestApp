//
//  ProfileView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI
import PhotosUI

enum ProfileActionStyle: Equatable {
    case navigate, none, logOut, help
    case info(String)
}

struct ProfileAction {
    var icon: Image
    var text: String
    var style: ProfileActionStyle
}

struct ProfileView: View {
    @ObservedObject var userService = UsersService.shared
    
    private var actions: [ProfileAction] = [
        ProfileAction(icon: Image("cardIcon"), text: Strings.tradeStore, style: .navigate),
        ProfileAction(icon: Image("cardIcon"), text: Strings.paymentMethod, style: .navigate),
        ProfileAction(icon: Image("cardIcon"), text: Strings.balance, style: .info("$1593")),
        ProfileAction(icon: Image("cardIcon"), text: Strings.tradeHistory, style: .navigate),
        ProfileAction(icon: Image("restoreIcon"), text: Strings.restorePurchases, style: .navigate),
        ProfileAction(icon: Image("helpIcon"), text: Strings.help, style: .help),
        ProfileAction(icon: Image("logOutIcon"), text: Strings.logOut, style: .logOut)
    ]
    
    @State private var pickerShown: Bool = false
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    @State private var showLogOutAlert: Bool = false
    
    var body: some View {
        
        VStack {
            Text(Strings.profile)
                .font(.montserratBold16)
            
            if let avatarImage = avatarImage {
                avatarImage
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .padding(.top, 20)
            } else {
                Image(systemName: "person.crop.circle.dashed")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .padding(.top, 20)
            }
            
            PhotosPicker(selection: $avatarItem, matching: .images) {
                Text(Strings.changePhoto)
                    .font(.montserratRegular12)
                    .foregroundColor(.black)
            }
            .padding(.top, 8)
            
            Text(userService.currentUser?.name ?? "Unknown")
                .padding(.top, 5)
                .font(.montserratBold16)
            
            CommonButton(title: Strings.uploadItem, image: Image("uploadIcon")) {
                
            }
            .padding(.horizontal, 42)
            .padding(.top, 38)
            
            ScrollView(showsIndicators: false) {
                ForEach(actions, id: \.text) { action in
                    ProfileActionButtonView(
                        icon: action.icon,
                        text: action.text,
                        style: action.style,
                        action: {
                            switch action.style {
                            case .logOut:
                                showLogOutAlert = true
                            case .help:
                                if let tgURL = URL.init(string: "tg://resolve?domain=Moremist") {
                                    UIApplication.shared.open(tgURL)
                                }
                            default:
                                return
                            }
                        }
                    )
                    .padding(.top, 25)
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 14)
            
            Spacer()
        }
        .onChange(of: avatarItem) { _ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        userService.saveCurrentUserAvatar(image: uiImage)
                        avatarImage = Image(uiImage: uiImage)
                        return
                    }
                }
            }
        }
        .onAppear {
            if let image = userService.getCurrentUserAvatar() {
                avatarImage = Image(uiImage: image)
            }
        }
        .alert("Are you sure?", isPresented: $showLogOutAlert) {
            Button("Log out") {
                avatarImage = nil
                userService.logOut()
            }
            Button("Cancel", role: .cancel) {
                showLogOutAlert = false
            }
        }
    }
}

struct ProfileActionButtonView: View {
    private let userService = UsersService.shared
    
    var icon: Image
    var text: String
    var style: ProfileActionStyle
    
    var action: () -> Void
    
    var body: some View {
        Button(
            action: {
                action()
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
        case .none, .logOut, .help:
            return EmptyView().eraseToAnyView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
