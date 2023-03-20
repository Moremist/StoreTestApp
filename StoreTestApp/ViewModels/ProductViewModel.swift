//
//  ProductViewModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 20.03.2023.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    private let latestSeenProductsURLString = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
    private let flashSaleProductsURLString = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
    
    private var latestProductSubject = PassthroughSubject<[ProductModel], Never>()
    private var flashSaleProductSubject = PassthroughSubject<[ProductModel], Never>()
    
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
        guard let url = URL(string: latestSeenProductsURLString) else {
            print("Invalid URLString")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(LatestProductModels.self, from: data) {
                self.latestProductSubject.send(decodedResponse.latest)
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func fetchFlashSaleProducts() async {
        guard let url = URL(string: flashSaleProductsURLString) else {
            print("Invalid URLString")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(FlashSaleProductModels.self, from: data) {
                self.flashSaleProductSubject.send(decodedResponse.flashSale)
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func addProductToCart(product: ProductModel) {
        
    }
    
    func addProductToFavourite(product: ProductModel) {
        
    }
}
