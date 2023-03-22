//
//  CommonAlertView.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 22.03.2023.
//

import SwiftUI

struct CommonAlertView: View {
    var title: String
    var description: String
    
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Color("textSecondaryColor")
                        .opacity(0.7)
                    VStack {
                        Group {
                            Text(title)
                                .font(.montserratBold24)
                                .padding(.bottom)
                            Text(description)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.2)
                                .font(.montserratRegular24)
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.all, 20)
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height / 5)
            .cornerRadius(40)
        }
        .opacity(isPresented ? 1 : 0)
        .onChange(of: isPresented) { newValue in
            if newValue {
                Task {
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    withAnimation {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct CommonAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CommonAlertView(title: "Errror", description: "Error descriptionError descriptionError descriptionError descriptionError description", isPresented: .constant(true))
    }
}
