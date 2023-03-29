//
//  ProductDetailsView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 23.03.2023.
//

import SwiftUI
import CachedAsyncImage

struct ProductDetailsView: View {
    @StateObject var viewModel = ProductDetailsViewModel()
    
    var product: ProductDetailModel {
        return viewModel.productDetails ?? ProductDetailModel.dummyModel
    }
    
    @State private var selectedImageIndex: Int = 0
    
    @State private var offset: CGFloat = 200
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    ProductImageScrollView(images: product.imageUrls, selectedImageIndex: $selectedImageIndex)
                        .padding()
                    
                    ProductImagePreviewsView(images: product.imageUrls, selectedIndex: $selectedImageIndex)
                        .padding(.bottom, 29)
                    
                    HStack {
                        Text(product.name)
                            .font(.montserratBold20)
                        
                        Spacer(minLength: UIScreen.main.bounds.width / 2)
                        
                        Text("$ " + product.price.description)
                            .font(.montserratBold20)
                    }
                    .padding(.bottom, 15)
                    
                    HStack {
                        Text(product.description)
                            .font(.montserratRegular16)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: UIScreen.main.bounds.width / 4)
                    }
                    .padding(.bottom, 15)
                    
                    HStack {
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                        
                        Text(product.rating.description)
                            .font(.montserratBold16)
                        
                        Text("(" + product.numberOfReviews.description + " reviews)")
                            .font(.montserratRegular16)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding(.bottom, 17)
                    
                    HStack {
                        VStack {
                            Text("Color:")
                                .font(.montserratBold16)
                                .foregroundColor(.gray)
                                .padding(.bottom, 13)
                        }
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(product.colors, id: \.self) { color in
                                Button {
                                    
                                } label: {
                                    Color(hex: color)
                                        .frame(width: 32, height: 24)
                                        .cornerRadius(8)
                                        .if(color.lowercased() == "#ffffff") { view in
                                            view
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(.gray, lineWidth: 1)
                                                }
                                        }
                                        .padding(.horizontal, 1)
                                }
                                
                            }
                        }
                    }
                    
                    Color
                        .clear
                        .frame(height: 80)
                }
                .padding(.horizontal, 25)
                .task {
                    await viewModel.fetchProductDetails()
                }
            }
            
            ProductDetailsBottomView()
                .offset(y: offset)
                .onChange(of: product) { _ in
                    withAnimation(.spring()) {
                        offset = 0
                    }
                }
        }
    }
}

struct ProductDetailsBottomView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.bottom)
                .foregroundColor(Color.detailBottomColor)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 11) {
                        Text(Strings.quantity)
                            .foregroundColor(.gray)
                            .font(.montserratRegular14)
                        HStack(spacing: 21) {
                            ProductDetailsBottomViewButton(iconName: "minus") {
                                
                            }
                            
                            ProductDetailsBottomViewButton(iconName: "plus") {
                                
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 170, height: 44)
                                .foregroundColor(Color.textSecondaryColor)
                            
                            HStack {
                                Text(Strings.idk2500)
                                    .foregroundColor(.white.opacity(0.5))
                                    .font(.montserratRegular10)
                                
                                Text(Strings.addToCart)
                                    .foregroundColor(.white)
                                    .font(.montserratBold10)
                            }
                        }
                    }
                    
                }
                .padding(.horizontal, 24)
                .padding(.top, 17)
                
                Spacer()
            }
        }
        .frame(height: 158)
    }
}

struct ProductDetailsBottomViewButton: View {
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 38, height: 22)
                    .foregroundColor(Color.textSecondaryColor)
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 7, height: 7)
            }
        }
    }
}

struct ProductImageScrollView: View {
    var images: [String]
    
    @Binding var selectedImageIndex: Int
    
    var body: some View {
        let cellHeight = UIScreen.main.bounds.height / 3
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<images.count, id: \.self) { index in
                if let url = URL(string: images[index]) {
                    CachedAsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .tag(index)
                }
            }
        }
        .frame(
            height: cellHeight
        )
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct ProductImagePreviewsView: View {
    var images: [String]
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<images.count, id: \.self) { index in
                Button {
                    selectedIndex = index
                } label: {
                    if let url = URL(string: images[index]) {
                        let cellWidth: CGFloat = selectedIndex == index ? 83 : 65
                        let cellHeight: CGFloat = selectedIndex == index ? 45 : 37
                        CachedAsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: cellWidth, height: cellHeight)
                        } placeholder: {
                            ProgressView()
                        }
                        .cornerRadius(8)
                    }
                }
                .if(selectedIndex == index) { view in
                    view
                        .shadow(radius: 5, x: 0, y: 5)
                }
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}
