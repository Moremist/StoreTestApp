//
//  AlertSupported.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 22.03.2023.
//

import Foundation
import SwiftUI

class AlertSupported: ObservableObject {
    @Published var alertPresented: Bool = false

    var alertTitle: String = ""
    var alertDescription: String = ""


    func showAlert(title: String, description: String) {
        alertTitle = title
        alertDescription = description
        withAnimation {
            alertPresented = true
        }
    }

}
