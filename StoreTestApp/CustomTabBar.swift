//
//  CustomTabBar.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 22.03.2023.
//

import SwiftUI

struct CustomTabBar: View {
    private var tabBarImagesStrings: [String] = [
        "home",
        "heart",
        "cart",
        "dialog",
        "person"
    ]
    
    @Binding var selectedIndex: Int
    
    init(selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("mainBGColor"))
            Rectangle()
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .foregroundColor(.white)
            
            HStack {
                ForEach(tabBarImagesStrings.indices, id: \.self) { index in
                    HStack {
                        Spacer()
                        Button {
                            selectedIndex = index
                        } label: {
                            ZStack {
                                if selectedIndex == index {
                                    Circle()
                                        .foregroundColor(Color("backgroundCircleColor"))
                                        .frame(width: 40, height: 40)
                                }
                                
                                Image(tabBarImagesStrings[index])
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .frame(height: 83)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            CustomTabBar(selectedIndex: .constant(1))
        }
    }
}
