//
//  CartView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 28.03.2023.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CartViewModel = CartViewModel()
    @Binding var selectedIndex: Int
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Cart")
                        .font(.montserratBold36)
                        .foregroundColor(Color.textSecondaryColor)
                    
                    Spacer()
                }
                .padding(.horizontal, 55)
                
                List {
                    ForEach(viewModel.cart, id: \.name) { product in
                        CartCellView(product: product)
                            .listRowBackground(Color.mainBGColor)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                    }
                    .onDelete(perform: viewModel.deleteProduct(at:))
                }
                .scrollContentBackground(.hidden)
                .overlay(
                    Group {
                        if(viewModel.cart.isEmpty) {
                            CartEmptyView(selectedIndex: $selectedIndex)
                        }
                    }
                )
                
                CartBottomView(summary: viewModel.cartSummary)
            }
            .background(Color.mainBGColor)
        }
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
    @State private var offset: CGFloat = 123
    
    var summary: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.bottom)
                .foregroundColor(Color.detailBottomColor)
            
            VStack {
                NavigationLink(
                    destination:
                        Text("Check out view in progress :)")
                        .font(.montserratBold20),
                    label: {
                        Text("Check out " + summary.description + "$")
                            .font(.montserratBold24)
                            .foregroundColor(.white)
                        
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color.textSecondaryColor)
                            )
                    }
                )
                .padding()
                
                Spacer()
            }
        }
        .frame(height: 123)
        .offset(y: offset)
        .onAppear {
            if summary > 0.0 {
                withAnimation {
                    self.offset = 0
                }
            }
        }
        .onChange(of: summary) { newValue in
            if newValue == 0.0 {
                withAnimation {
                    self.offset = 123
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel(), selectedIndex: .constant(2))
    }
}
