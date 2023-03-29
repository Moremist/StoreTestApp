//
//  CartView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 28.03.2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var userService = UsersService.shared
    @Binding var selectedIndex: Int
    
    private var cart: [ProductModel] {
        userService.currentUserCart
    }
    
    private var cartSummary: Double {
        cart.reduce(0.0) { $0 + $1.price }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Cart")
                    .font(.montserratBold36)
                    .foregroundColor(Color.textSecondaryColor)
                
                Spacer()
            }
            .padding(.horizontal, 55)
            
            List {
                ForEach(userService.currentUserCart, id: \.name) { product in
                    CartCellView(product: product)
                        .listRowBackground(Color.mainBGColor)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                }
                .onDelete(perform: deleteProduct(at:))
            }
            .scrollContentBackground(.hidden)
            .overlay(
                Group {
                    if(userService.currentUserCart.isEmpty) {
                        CartEmptyView(selectedIndex: $selectedIndex)
                    }
                }
            )
            
            CartBottomView(summary: cartSummary)
        }
        .background(Color.mainBGColor)
    }
    
    private func deleteProduct(at offset: IndexSet) {
        userService.currentUserCart.remove(atOffsets: offset)
    }
}

struct CartEmptyView: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        ZStack {
            Color.mainBGColor
            VStack(spacing: 20) {
                Image(systemName: "basket")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.textSecondaryColor)
                
                Text("Nothing to present :(")
                    .font(.montserratBold20)
                    .foregroundColor(Color.textSecondaryColor)
                
                Button {
                    selectedIndex = 0
                } label: {
                    Text("Tap to go shopping")
                        .font(.montserratRegular16)
                        .foregroundColor(.white)
                        .padding(.horizontal, 35)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .foregroundColor(Color.textSecondaryColor)
                        )
                }
                .frame(height: 35)
            }
        }
    }
}

struct CartBottomView: View {
    var summary: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.bottom)
                .foregroundColor(Color.detailBottomColor)
            
            VStack {
                HStack {
                    Text("Summary: " + summary.description + "$")
                        .font(.montserratRegular24)
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
            }
        }
        .frame(height: 123)
        .offset(y: summary == 0 ? 123 : 0)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(selectedIndex: .constant(2))
    }
}
