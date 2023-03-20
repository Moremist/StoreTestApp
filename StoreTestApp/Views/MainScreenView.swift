//
//  MainScreenView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct MainScreenView: View {
    @AppStorage("loggedIn") private var loggedIn = false
    
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
        }
        .overlay {
            SignInView(isPresented: !loggedIn)
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
