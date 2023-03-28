//
//  CartView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 28.03.2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var userService = UsersService.shared
    
    var cartSummary: Double {
        userService.currentUserCart.reduce(0.0) { $0 + $1.price }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Cart")
                    .font(.montserratBold36)
                Spacer()
            }
            .padding(.horizontal, 55)
            
            List {
                ForEach(userService.currentUserCart, id: \.name) { product in
                    let quantity = userService.currentUserCart.filter({$0.name == product.name}).count
                    CartCellView(product: product, count: quantity)
                        .listRowBackground(Color("mainBGColor"))
                }
                .onDelete(perform: deleteProduct(at:))
            }
            .scrollContentBackground(.hidden)
            .overlay(
                Group {
                    if(userService.currentUserCart.isEmpty) {
                        Color("mainBGColor")
                    }
                }
            )
            
            Spacer()
            
            HStack {
                Text("Summary: " + cartSummary.description + "$")
                    .font(.montserratRegular24)
            }
        }
        .padding(.bottom, 63)
        .background(Color("mainBGColor"))
    }
    
    private func deleteProduct(at offset: IndexSet) {
        userService.currentUserCart.remove(atOffsets: offset)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
