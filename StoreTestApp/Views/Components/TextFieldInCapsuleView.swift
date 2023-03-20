//
//  TextFieldInCapsuleView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct TextFieldInCapsuleView: View {
    @Binding var text: String
    @State var isTextHidden = true
    var placeHolder: String
    var isProtected: Bool = false
    var isSearch: Bool = false
    
    init(text: Binding<String>, placeHolder: String, isProtected: Bool = false, isSearch: Bool = false) {
        self._text = text
        self.placeHolder = placeHolder
        self.isProtected = isProtected
        self.isSearch = isSearch
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Capsule()
                .foregroundColor(Color(UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)))
            
            if isTextHidden && isProtected {
                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        HStack{
                            Spacer()
                            Text(placeHolder)
                                .font(.montserratRegular12)
                            Spacer()
                        }
                    }
                    .font(.montserratRegular12)
                    .multilineTextAlignment(.center)
            } else {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty, placeholder: {
                        HStack{
                            Spacer()
                            Text(placeHolder)
                                .font(.montserratRegular12)
                            Spacer()
                        }
                    })
                    .font(.montserratRegular12)
                    .multilineTextAlignment(.center)
            }
            
            
            if isProtected {
                HStack {
                    Spacer()
                    
                    Button {
                        isTextHidden.toggle()
                    } label: {
                        Image("hideButtonIcon")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    
                }
                .padding(.trailing, 15)
            }
        }
        .if(isSearch, transform: { view in
            view
                .overlay {
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 18)
                }
        })
        .frame(height: 29)
    }
}

struct TextFieldInCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldInCapsuleView(text: .constant(""), placeHolder: Strings.firstName, isProtected: true)
    }
}
