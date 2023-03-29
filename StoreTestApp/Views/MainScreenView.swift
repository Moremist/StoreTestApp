//
//  MainScreenView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct MainScreenView: View {
    @AppStorage(UserDefaults.Keys.loggedInKey) private var loggedIn = false
    @State var selectedIndex: Int = 0
    
    private let userService = UsersService.shared
    private let productViewModel = ProductViewModel()
    
    var body: some View {
        ZStack {
            Color("mainBGColor")
                .edgesIgnoringSafeArea(.all)
            
            switch selectedIndex {
            case 0:
                ProductsView(viewModel: productViewModel, selectedTab: $selectedIndex)
            case 2:
                CartView(selectedIndex: $selectedIndex)
            case 3:
            #if targetEnvironment(simulator)
                CoreDataDebugView()
            #else
                Color("mainBGColor")
                    .edgesIgnoringSafeArea(.all)
            #endif
                
            case 4:
                ProfileView()
            default:
                Color("mainBGColor")
                    .edgesIgnoringSafeArea(.all)
            }
            
            CustomTabBar(selectedIndex: $selectedIndex)
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
