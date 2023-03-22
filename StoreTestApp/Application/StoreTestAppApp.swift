//
//  StoreTestAppApp.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

@main
struct StoreTestAppApp: App {
    let context = UsersService.shared.persistentContainer.viewContext
    
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environment(\.managedObjectContext, context)
        }
    }
}
