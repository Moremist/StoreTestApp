//
//  LogInButtonView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 19.03.2023.
//

import SwiftUI

struct LogInButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(16)
                .foregroundColor(Color(UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1)))
            
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.montserratBold16)
                    .foregroundColor(.white)
            })
        }
        .frame(height: 46)
    }
}

struct LogInButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogInButtonView(title: Strings.logIn, action: {})
    }
}
