//
//  ProductModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 20.03.2023.
//

import Foundation

struct LatestProductModels: Codable {
    let latest: [ProductModel]
}

struct FlashSaleProductModels: Codable {
    let flashSale: [ProductModel]
    
    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

// MARK: - Latest
struct ProductModel: Codable {
    let category, name: String
    let price: Double
    let discount: Int?
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageURL = "image_url"
    }
}
