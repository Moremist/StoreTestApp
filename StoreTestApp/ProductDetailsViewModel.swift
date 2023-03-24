//
//  ProductDetailsViewModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 24.03.2023.
//

import Foundation

class ProductDetailsViewModel: ObservableObject {
    private let networkService = NetworkService()
    private let productDetailsURLString = "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
    
    @Published var productDetails: ProductDetailModel?
    
    func fetchProductDetails() async {
        if let response: ProductDetailModel = await networkService.fetchData(urlString: productDetailsURLString) {
            self.productDetails = response
        }
    }
}
