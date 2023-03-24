//
//  ProductDetailModel.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 23.03.2023.
//

import Foundation

class ProductDetailModel: Decodable {
    let name, description: String
    let rating: Double
    let numberOfReviews, price: Int
    let colors: [String]
    let imageUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, description, rating
        case numberOfReviews = "number_of_reviews"
        case price, colors
        case imageUrls = "image_urls"
    }
    
    init(name: String, description: String, rating: Double, numberOfReviews: Int, price: Int, colors: [String], imageUrls: [String]) {
        self.name = name
        self.description = description
        self.rating = rating
        self.numberOfReviews = numberOfReviews
        self.price = price
        self.colors = colors
        self.imageUrls = imageUrls
    }
    
    static let dummyModel = ProductDetailModel(name: "", description: "", rating: 0.0, numberOfReviews: 0, price: 0, colors: [], imageUrls: [])
}
