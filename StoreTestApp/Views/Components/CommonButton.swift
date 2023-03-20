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
                    HStack(spacing: 0) {
                        Group {
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.white)
                            } else {
                                EmptyView()
                            }
                        }
                        .frame(width: reader.size.width / 3)
                        
                        Text(title)
                            .font(.montserratBold16)
                            .foregroundColor(.white)
                            .frame(width: reader.size.width / 3)
                        
                        Group {
                            if let _ = image {
                                Spacer()
                                    .frame(width: reader.size.width / 3)
                            }
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
