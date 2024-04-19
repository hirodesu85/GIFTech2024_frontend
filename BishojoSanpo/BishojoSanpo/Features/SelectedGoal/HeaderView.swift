//
//  HeaderView.swift
//  BishojoSanpo
//
//  Created by 尾形拓夢 on 2024/04/12.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            WebPImageView(imageName: "NewHeader.webp")
                .edgesIgnoringSafeArea(.all)
                .shadow(color: Color(red: 0, green: 0, blue: 0.2, opacity: 0.35),
                        radius: 10,
                        x: 0, y: 5)
            HStack {
                Text("wwwwwwwww")
                    .padding(.leading, 10)
                    .padding(.top, 30)
                    .foregroundStyle(.white)
                    .font(.system(size: 25))
                Spacer()
                Button(action: {
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

