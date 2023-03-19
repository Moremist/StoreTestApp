//
//  CommonButton.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct CommonButton: View {
    var title: String
    var image: Image?
    var action: () -> Void
        
    var body: some View {
        GeometryReader { reader in
            Button(action: {
                action()
            }, label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(16)
                        .foregroundColor(Color(UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)))
                    HStack {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.white)
                                .padding(.trailing, reader.size.width / 5)
                        }
                        Text(title)
                            .font(.montserratBold16)
                            .foregroundColor(.white)
                            .if(image != nil) { view in
                                view
                                    .padding(.trailing, reader.size.width / 5)
                            }
                    }
                    
                }
            })
        }
        .frame(height: 46)

    }
}

struct CommonButton_Previews: PreviewProvider {
    static var previews: some View {
        CommonButton(title: Strings.logIn, image: Image("uploadIcon"), action: {})
    }
}
