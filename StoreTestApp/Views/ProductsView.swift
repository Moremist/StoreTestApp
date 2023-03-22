//
//  ProductsView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 20.03.2023.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var viewModel = ProductViewModel()
    
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            ProductHeaderView()
                .padding(.top, 24)
            
            TextFieldInCapsuleView(text: $searchText, placeHolder: Strings.whatAreYouLookingFor, isSearch: true, type: .alphabet)
                .padding(.horizontal, 56)
            
            ProductCategoriesButtonsView()
                .padding(.horizontal, 16)
                .padding(.top, 16)
            
            if viewModel.isProductsLoaded {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ProductsScrollView(
                            products: viewModel.latestProductModels,
                            title: Strings.latestDeals,
                            addProduct: viewModel.addProductToCart(product:),
                            cellSize: CGSize(width: 114, height: 149)
                        )
                        .padding(.horizontal, 12)
                        .padding(.top, 30)
                        
                        let screenSize = UIScreen.main.bounds.width
                        let flashSaleCellWidth = screenSize / 2 - 22
                        let flashSaleCellSize = CGSize(width: flashSaleCellWidth, height: flashSaleCellWidth * 1.2)
                        
                        ProductsScrollView(
                            products: viewModel.flashSaleProductModels,
                            title: Strings.flashSale,
                            addProduct: viewModel.addProductToCart(product:),
                            addToFavourite: viewModel.addProductToFavourite(product:),
                            cellSize: flashSaleCellSize
                        )
                        .padding(.horizontal, 12)
                        .padding(.top, 30)
                    }
                }
            } else {
                VStack {
                    Spacer()
                    ProgressView(Strings.loading)
                    Spacer()
                }
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                await viewModel.fetchLastSeenProducts()
                await viewModel.fetchFlashSaleProducts()
            }
        }
    }
}

struct ProductHeaderView: View {
    var body: some View {
        HStack(alignment: .top) {
            Button {
                
            } label: {
                Image("menuButtonIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
            }
            
            Spacer()
            
            HStack {
                Text(Strings.tradeBy)
                    .font(.montserratBold24)
                Text(Strings.bata)
                    .font(.montserratBold24)
                    .foregroundColor(Color("textSecondaryColor"))
            }
            
            Spacer()
            
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "person.crop.circle.dashed")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
                
                Button {
                    
                } label: {
                    HStack(spacing: 4.5) {
                        Text(Strings.location)
                            .font(.montserratRegular12)
                            .foregroundColor(.black)
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 6, height: 3)
                            .foregroundColor(.black)
                    }
                }
                
            }
            
        }
        .padding(.leading, 15)
        .padding(.trailing, 45)
    }
}

struct ProductCategory {
    var imageName: String
    var name: String
}

struct ProductCategoriesButtonsView: View {
    private var categories: [ProductCategory] = [
        ProductCategory(imageName: "phoneIcon", name: "Phones"),
        ProductCategory(imageName: "headphonesIcon", name: "Headphones"),
        ProductCategory(imageName: "gamepadIcon", name: "Games"),
        ProductCategory(imageName: "carIcon", name: "Cars"),
        ProductCategory(imageName: "bedIcon", name: "Furniture"),
        ProductCategory(imageName: "robotIcon", name: "kids")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(categories,  id: \.name) { category in
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        
                    } label: {
                        VStack {
                            ZStack {
                                Circle()
                                    .frame(width: 42, height: 38)
                                    .scaledToFit()
                                    .foregroundColor(Color("backgroundCircleColor"))
                                Image(category.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            
                            Text(category.name)
                                .scaledToFit()
                                .minimumScaleFactor(0.8)
                                .font(.montserratRegular8)
                                .foregroundColor(.gray)
                        }
                    }

                    Spacer()
                }
            }
        }
    }
}

struct ProductsScrollView: View {
    var products: [ProductModel]
    var title: String
    var addProduct: (ProductModel) -> Void
    var addToFavourite: ((ProductModel) -> Void)?
    var cellSize: CGSize
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.montserratRegular24)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text(Strings.viewAll)
                            .font(.montserratRegular16)
                            .foregroundColor(.gray)
                    }
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(products, id: \.name) { product in
                            ProductCellView(
                                product: product,
                                addProductAction: addProduct,
                                favouriteAction: addToFavourite
                            )
                            .frame(width: cellSize.width, height: cellSize.height)
                        }
                    }
                }
            }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
