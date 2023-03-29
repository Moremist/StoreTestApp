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
        .padding()
        .frame(height: 120)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color("backgroundCircleColor"))
        )
    }
}

struct CartCellView_Previews: PreviewProvider {
    static var previews: some View {
        CartCellView(product: ProductModel.dummyModel)
    }
}
