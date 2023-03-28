//
//  ProductViewModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 20.03.2023.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    private let userService = UsersService.shared

    private let latestSeenProductsURLString = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
    private let flashSaleProductsURLString = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
    
    private var latestProductSubject = PassthroughSubject<[ProductModel], Never>()
    private var flashSaleProductSubject = PassthroughSubject<[ProductModel], Never>()
    
    private let networkService = NetworkService()
    
    private var commonCancellables = Set<AnyCancellable>()
    
    @Published var latestProductModels: [ProductModel] = []
    @Published var flashSaleProductModels: [ProductModel] = []
    
    var isProductsLoaded: Bool {
        return !latestProductModels.isEmpty && !flashSaleProductModels.isEmpty
    }
    
    init() {
        latestProductSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                guard let self else { return }
                self.latestProductModels = products
            }
            .store(in: &commonCancellables)
        
        flashSaleProductSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                guard let self else { return }
                self.flashSaleProductModels = products
            }
            .store(in: &commonCancellables)
    }
    
    func fetchLastSeenProducts() async {
        if let response: LatestProductModels = await networkService.fetchData(urlString: latestSeenProductsURLString) {
            self.latestProductSubject.send(response.latest)
        }
    }
    
    func fetchFlashSaleProducts() async {
        if let response: FlashSaleProductModels = await networkService.fetchData(urlString: flashSaleProductsURLString) {
            self.flashSaleProductSubject.send(response.flashSale)
        }
    }
    
    func addProductToCart(product: ProductModel) {
        userService.currentUserCart.append(product)
    }
    
    func addProductToFavourite(product: ProductModel) {
        
    }
}
