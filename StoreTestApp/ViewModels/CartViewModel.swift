//
//  CartViewModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 29.03.2023.
//

import Foundation
import Combine

class CartViewModel: ObservableObject {
    private var userService = UsersService.shared
    
    var cart: [ProductModel] {
        userService.currentUserCart
    }
    
    @Published var cartSummary: Double = 0.0
    
    private var commonCancellables = Set<AnyCancellable>()
    
    init() {
        userService.$currentUserCart
            .sink { [weak self] products in
                guard let self = self else { return }
                self.cartSummary = products.reduce(0.0) { $0 + $1.price }
            }
            .store(in: &commonCancellables)
    }
    
    
    func deleteProduct(at offset: IndexSet) {
        userService.currentUserCart.remove(atOffsets: offset)
    }
}
 
