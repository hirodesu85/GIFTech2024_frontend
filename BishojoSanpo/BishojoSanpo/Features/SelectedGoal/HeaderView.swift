//
//  HeaderView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        ZStack {
            WebPImageView(imageName: "NewHeader.webp")
                .edgesIgnoringSafeArea(.all)
                .shadow(color: Color(red: 0, green: 0, blue: 0.2, opacity: 0.35),
                        radius: 10,
                        x: 0, y: 5)
            HStack {
                Text("音子")
                    .padding(.leading, 10)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                    .foregroundStyle(.white)
                Spacer()
                Button(action: {
                    router.returnToHome()
                }) {
                    WebPImageView(imageName: "HomeButton.webp")
                        .frame(width: 70, height: 70)
                        .padding(.trailing, 12)
                }
                
            }
        }
    }
}

#Preview {
    HeaderView()
}

