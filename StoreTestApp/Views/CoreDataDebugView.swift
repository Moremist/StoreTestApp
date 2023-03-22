//
//  CoreDataDebugView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 22.03.2023.
//

import Foundation
import SwiftUI

struct CoreDataDebugView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \UserModel.name, ascending: true)]) var users: FetchedResults<UserModel>
    @ObservedObject var userService = UsersService.shared

    var body: some View {
        VStack {
            List {
                ForEach(users) { user in
                    VStack {
                        Text(user.name ?? "Unknown")
                        Text(user.email ?? "Unknown")
                        Text(user.password ?? "Unknown")
                    }
                }
            }
            Spacer()
            
            Button("Delete all") {
                userService.clearUsers()
            }
        }
    }
}
