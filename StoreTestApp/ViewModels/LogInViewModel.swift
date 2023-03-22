//
//  LogInViewModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 22.03.2023.
//

import Foundation
import SwiftUI

class LogInViewModel: AlertSupported {
    private let userService = UsersService.shared

    func checkUser(email: String) -> Bool {
        guard !email.isEmpty else {
            showAlert(title: "Error", description: "Enter email")
            return false
        }
        
        guard email.isValidEmail() else {
            showAlert(title: "Error", description: "Enter valid email")
            return false
        }
        
        if let user = userService.getUserByEmail(userEmail: email) {
            userService.logInUser(user: user)
            return true
        } else {
            showAlert(title: "Error", description: "User's email didn't found")
            return false
        }
    }
}
