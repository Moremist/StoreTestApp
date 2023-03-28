//
//  CartCellView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 28.03.2023.
//

import SwiftUI
import CachedAsyncImage

struct CartCellView: View {
    var product: ProductModel
    var count: Int
    
    var body: some View {
        HStack {
            if let url = URL(string: product.imageURL) {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 100)
                } placeholder: {
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.montserratBold16)
                Text("$ " + product.price.description)
                    .font(.montserratRegular16)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
}

struct CartCellView_Previews: PreviewProvider {
    static var previews: some View {
        CartCellView(
            product: ProductModel(
                category: "Phones",
                name: "Samsung S10",
                price: 1000,
                discount: 10,
                imageURL: "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg"
            ),
            count: 5
        )
    }
}
