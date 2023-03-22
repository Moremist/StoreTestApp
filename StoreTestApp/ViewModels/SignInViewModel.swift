//
//  SignInViewModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 21.03.2023.
//

import Foundation
import SwiftUI

class SignInViewModel: AlertSupported {
    private let userService = UsersService.shared

    
    func registerUser(firstName: String, lastName: String, email: String) {
        
        guard !firstName.isEmpty else {
            showAlert(title: "Warning", description: "Enter valid first name")
            return
        }
        
        guard !lastName.isEmpty else {
            showAlert(title: "Warning", description: "Enter valid second name")
            return
        }
        
        guard email.isValidEmail() else {
            showAlert(title: "Warning", description: "Enter valid email")
            return
        }
        
        if let _ = userService.getUserByEmail(userEmail: email) {
            showAlert(title: "Warning", description: "Email is already registered. User LogIn button to log in")
            return
        }

        
        do {
            try userService.registerUser(name: firstName + " " + lastName, email: email)
        } catch(let error) {
            showAlert(title: "Error", description: "User can't be saved: \(error.localizedDescription)")
        }
    }
}
