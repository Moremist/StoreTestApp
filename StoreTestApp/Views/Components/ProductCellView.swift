//
//  ProductCellView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 20.03.2023.
//

import SwiftUI
import CachedAsyncImage

struct ProductCellView: View {
    var product: ProductModel
    
    var addProductAction: (ProductModel) -> Void
    var favouriteAction: ((ProductModel) -> Void)?
    
    var body: some View {
        GeometryReader { reader in
            let cellHeight = reader.size.height
            let cellWidth = reader.size.width
            
            ZStack {
                NavigationLink {
                    ProductDetailsView()
                } label: {
                    CachedAsyncImage(url: URL(string: product.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: cellWidth, height: cellHeight)
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(10)
                }
                
                ZStack {
                    VStack {
                        if let discount = product.discount {
                            VStack {
                                HStack(alignment: .top) {
                                    Spacer()
                                    ZStack {
                                        Capsule()
                                            .foregroundColor(.red)
                                        makeDiscountString(discount: discount)
                                            .minimumScaleFactor(0.1)
                                            .lineLimit(1)
                                            .font(.montserratRegular12)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 7)
                                    }
                                    .frame(width: cellWidth / 3.5, height: cellHeight / 12.5)
                                }
                                .padding(.trailing, 8)
                                .padding(.top, 7)
                            }
                        }
                        Spacer()
                    }
                    
                    VStack(spacing: 0) {
                        Spacer(minLength: cellHeight / 2)
                        
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                ZStack {
                                    Capsule()
                                        .foregroundColor(Color("backgroundCircleColor"))
                                        .opacity(0.85)
                                    
                                    Text(product.category)
                                        .minimumScaleFactor(0.1)
                                        .lineLimit(1)
                                        .font(.montserratRegular12)
                                        .padding(.horizontal, 7)
                                }
                                .frame(width: cellWidth / 3.5, height: cellHeight / 12.5)
                                
                                StrokeText(text: product.name, width: 0.3, color: .black)
                                    .minimumScaleFactor(0.1)
                                    .font(.montserratBold20)
                                    .foregroundColor(.white)
                                
                                StrokeText(text: "$ " + product.price.description, width: 0.3, color: .black)
                                    .minimumScaleFactor(0.1)
                                    .font(.montserratBold16)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            HStack {
                                if let favouriteAction = favouriteAction {
                                    Button {
                                        favouriteAction(product)
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: cellWidth / 6.2, height: cellWidth / 6.2)
                                                .foregroundColor(Color("backgroundCircleColor"))
                                            Image(systemName: "heart")
                                                .resizable()
                                                .foregroundColor(.gray)
                                                .frame(width: cellWidth / 14.5, height: cellHeight / 22)
                                        }
                                    }
                                }
                                
                                
                                Button {
                                    addProductAction(product)
                                } label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: cellWidth / 5, height: cellWidth / 5)
                                            .foregroundColor(Color("backgroundCircleColor"))
                                        Image(systemName: "plus")
                                            .resizable()
                                            .foregroundColor(.gray)
                                            .frame(width: cellWidth / 13.4, height: cellHeight / 18.4)
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal, 7)
                    }
                    .padding(.bottom, 7)
                }
            }
        }
    }
    
    private func makeDiscountString(discount: Int) -> Text {
        let discountString = discount.description + "% off"
        return Text(discountString)
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(
            product:
                ProductModel(
                    category: "Phones",
                    name: "Samsung S10",
                    price: 1000,
                    discount: 10,
                    imageURL: "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg"
                ),
            addProductAction: {_ in},
            favouriteAction: {_ in}
        )
        //        .frame(width: 114, height: 149)
        .frame(width: 174, height: 221)
    }
}
