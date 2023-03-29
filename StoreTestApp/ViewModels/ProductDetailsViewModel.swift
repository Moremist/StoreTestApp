//
//  ProductDetailsViewModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 24.03.2023.
//

import Foundation

class ProductDetailsViewModel: ObservableObject {
    private let networkService = NetworkService()
    private let userService = UsersService.shared
    private let productDetailsURLString = "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
    
    @Published var productDetails: ProductDetailModel?
    
    func fetchProductDetails() async {
        if let response: ProductDetailModel = await networkService.fetchData(urlString: productDetailsURLString) {
            self.productDetails = response
        }
    }
    
    func addToCart() {
        guard let currentProduct = productDetails, let image = currentProduct.imageUrls.first else { return }
        let product = ProductModel(category: "", name: currentProduct.name, price: Double(currentProduct.price), discount: nil, imageURL: image)
        userService.currentUserCart.append(product)
    }
}
