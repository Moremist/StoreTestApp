//
//  UIApplication+Extensions.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import Foundation
import UIKit

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
