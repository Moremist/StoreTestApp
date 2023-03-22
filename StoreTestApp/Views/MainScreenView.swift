//
//  MainScreenView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct MainScreenView: View {
    @AppStorage(UserDefaults.Keys.loggedInKey) private var loggedIn = false
    private let userService = UsersService.shared
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color("mainBGColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                switch selectedIndex {
                case 0:
                    ProductsView()
                        .tabItem {
                            Label("Products", systemImage: "house.fill")
                        }
                case 4:
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                default:
                    Color("mainBGColor")
                        .edgesIgnoringSafeArea(.all)
                }
                
                CustomTabBar(selectedIndex: $selectedIndex)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .overlay {
            SignInView(isPresented: !loggedIn)
        }
        .onAppear {
            userService.setUpCurrentUserIfNeeded()
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var context = UsersService.shared.persistentContainer.viewContext
    static var previews: some View {
        MainScreenView()
            .environment(\.managedObjectContext, context)
    }
}
