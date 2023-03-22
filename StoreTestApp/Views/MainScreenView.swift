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
    
    var body: some View {
        TabView {
            ProductsView()
                .tabItem {
                    Label("Products", systemImage: "house.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            CoreDataDebugView()
                .tabItem {
                    Label("Debug", systemImage: "server.rack")
                }
            
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
